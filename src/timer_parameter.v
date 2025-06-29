`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2025 17:55:09
// Design Name: 
// Module Name: timer_parameter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module timer_parameter #(parameter fv=255)(
    input clk, reset_n,
    input enable,
    output done
    );
    
    localparam n=$clog2(fv);
    
    reg [n-1:0] Q_reg, Q_next;
    
    always @(posedge clk, negedge reset_n) begin
        if(~reset_n)
            Q_reg<=0;
        else
            Q_reg<=Q_next;
    end    
    
    always @(*) begin
        if(enable)
            Q_next=Q_reg+1;
        else
            Q_next=Q_reg;
    end
    
    assign done=(Q_reg==fv);
    
endmodule
