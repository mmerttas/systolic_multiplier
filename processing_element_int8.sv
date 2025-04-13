`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 16:57:06
// Design Name: 
// Module Name: PE_int8
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


module PE_int8( input  wire         clk, 
                input  wire         rst,
                input  wire signed [7: 0] x_in, 
                input  wire signed [7: 0] y_in, 
                output reg  signed [7: 0] x_out,  
                output reg  signed [7: 0] y_out,
                output reg  signed [15:0] result 
    ); 
    
    wire signed [15:0] mult;
    reg  signed [15:0] result_reg; 
    
    assign mult = x_in*y_in;  
    
    always@(posedge clk) begin 
    
        if(rst) begin 
            result     <= 16'b0; 
            //result_reg <= 16'b0;
            x_out      <= 8'b0; 
            y_out      <= 8'b0; 
        end 
        else begin 
            y_out      <= y_in; 
            x_out      <= x_in; 
            //result_reg <= result; 
            result     <= result + mult; 
        end 
    
    end 
    
endmodule

