`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.06.2025 18:05:38
// Design Name: 
// Module Name: delayed_debouncer_tb
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


module delayed_debouncer_tb(

    );
    
    reg clk, reset_n, noisy;
    wire debounced;
    integer i;
    
    delayed_debouncer uut(
        .clk(clk),
        .reset_n(reset_n),
        .noisy(noisy),
        .debounced(debounced)
    );
    
    localparam T = 10;
    always begin
        clk=1'b0;
        #(T/2);
        clk=1'b1;
        #(T/2);
    end
    
    localparam DELAY = 50_000_000;
    
    initial begin
        reset_n=1'b0;
        noisy=1'b0;
        #2  
        reset_n=1'b1;
        
        repeat(2) @(negedge clk);
        noisy=1'b1;
        
        #(DELAY);
        noisy=1'b0;
        
        #(DELAY);
        
        repeat(20) @(negedge clk);
        for(i=0;i<5;i=i+1)       
            #(DELAY/40) noisy=~noisy;
        
        #(DELAY/2);
        for(i=0;i<5;i=i+1)       
            #(DELAY/40) noisy=~noisy;

        #(DELAY/2);
        noisy=~noisy;
        for (i=0;i<5;i=i+1)       
            #(DELAY/40) noisy=~noisy;
                    
        #(DELAY/2);
        noisy=~noisy;
        
        #(DELAY/2);
        for (i=0;i<6;i=i+1)       
            #(DELAY/40) noisy=~noisy;

        #(DELAY/2) noisy=1'b0;                                                
        #(DELAY) $stop;
    end        
    
endmodule
