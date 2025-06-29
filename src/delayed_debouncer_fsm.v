`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2025 16:46:47
// Design Name: 
// Module Name: delayed_debouncer_fsm
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


module delayed_debouncer_fsm(
    input clk, reset_n,
    input noisy, timer_done,
    output timer_reset,debounced
    );
    
    reg [1:0] state_reg, state_next;
    localparam s0=0, s1=1, s2=2, s3=3;
    
    always @(posedge clk, negedge reset_n) begin
        if(~reset_n)
            state_reg<=2'b00;
        else
            state_reg<=state_next;
    end
    
    always @(*) begin
        case(state_reg) 
            s0:if(~noisy)
                    state_next=s0;
               else if(noisy)
                    state_next=s1;
            s1:if(~noisy)
                    state_next=s0;
               else if(noisy&~timer_done)
                    state_next=s1;
               else if(noisy&timer_done)
                    state_next=s2;
            s2:if(noisy)
                    state_next=s2;
               else if(~noisy)
                    state_next=s3;
            s3:if(noisy)
                    state_next=s2;
               else if(~noisy&~timer_done)
                    state_next=s3;
               else if(~noisy&timer_done)
                    state_next=s0;
            default:state_next=state_reg;
        endcase
    end
    
    assign timer_reset=(state_reg==s0)|(state_reg==s2);
    assign debounced=(state_reg==s2)|(state_reg==s3);
    
endmodule
