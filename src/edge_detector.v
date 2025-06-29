`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2025 18:46:50
// Design Name: 
// Module Name: edge_detector
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


module edge_detector(
        input clk, reset_n,
        input level,
        output p_edge, n_edge, any_edge
    );
    
    reg state_reg, state_next;
    localparam s0=0, s1=1;
    
    always @(posedge clk, negedge reset_n) begin
        if(~reset_n)
            state_reg<=1'b0;
        else
            state_reg<=state_next;
    end
    
    always @(*) begin
        case(state_reg)
            s0:if(~level)
                   state_next=s0;
               else
                   state_next=s1;
            s1:if(level)
                   state_next=s1;
               else
                   state_next=s0;
            default:state_next=state_reg;
        endcase
    end
    
    assign p_edge=(state_reg==s0)&level;
    assign n_edge=(state_reg==s1)&~level;
    assign any_edge=p_edge|n_edge;
    
endmodule
