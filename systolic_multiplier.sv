`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.04.2025 18:28:35
// Design Name: 
// Module Name: systolic_4x4
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


module systolic_4x4(    input  wire clk, 
                        input  wire rst, 
                        input  wire signed [7 : 0] x_i [3: 0], 
                        input  wire signed [7 : 0] y_i [3: 0],
                        output reg  signed [15: 0] out [15: 0]  
        );

    integer i;
    integer k;
    
    reg  signed [7 : 0] x_o [15: 0]; 
    reg  signed [7 : 0] y_o [15: 0]; 
    reg  signed [15: 0] r_o [15: 0]; 
    reg  [3: 0] counter;
    reg  done; 
    
    PE_int8 Pe_00 (.clk(clk), .rst(rst), .x_in(x_i[0]), .y_in(y_i[0]), .x_out(x_o[0]), .y_out(y_o[0]), .result(r_o[0]));
    PE_int8 Pe_01 (.clk(clk), .rst(rst), .x_in(x_o[0]), .y_in(y_i[1]), .x_out(x_o[1]), .y_out(y_o[1]), .result(r_o[1]));
    PE_int8 Pe_02 (.clk(clk), .rst(rst), .x_in(x_o[1]), .y_in(y_i[2]), .x_out(x_o[2]), .y_out(y_o[2]), .result(r_o[2]));
    PE_int8 Pe_03 (.clk(clk), .rst(rst), .x_in(x_o[2]), .y_in(y_i[3]), .x_out(x_o[3]), .y_out(y_o[3]), .result(r_o[3]));
    
    PE_int8 Pe_10 (.clk(clk), .rst(rst), .x_in(x_i[1]), .y_in(y_o[0]), .x_out(x_o[4]), .y_out(y_o[4]), .result(r_o[4]));
    PE_int8 Pe_11 (.clk(clk), .rst(rst), .x_in(x_o[4]), .y_in(y_o[1]), .x_out(x_o[5]), .y_out(y_o[5]), .result(r_o[5]));
    PE_int8 Pe_12 (.clk(clk), .rst(rst), .x_in(x_o[5]), .y_in(y_o[2]), .x_out(x_o[6]), .y_out(y_o[6]), .result(r_o[6]));
    PE_int8 Pe_13 (.clk(clk), .rst(rst), .x_in(x_o[6]), .y_in(y_o[3]), .x_out(x_o[7]), .y_out(y_o[7]), .result(r_o[7]));
    
    PE_int8 Pe_20 (.clk(clk), .rst(rst), .x_in(x_i[2]) , .y_in(y_o[4]), .x_out(x_o[8]),  .y_out(y_o[8]),   .result(r_o[8]));
    PE_int8 Pe_21 (.clk(clk), .rst(rst), .x_in(x_o[8]) , .y_in(y_o[5]), .x_out(x_o[9]),  .y_out(y_o[9]),   .result(r_o[9]));
    PE_int8 Pe_22 (.clk(clk), .rst(rst), .x_in(x_o[9]) , .y_in(y_o[6]), .x_out(x_o[10]), .y_out(y_o[10]),  .result(r_o[10]));
    PE_int8 Pe_23 (.clk(clk), .rst(rst), .x_in(x_o[10]), .y_in(y_o[7]), .x_out(x_o[11]), .y_out(y_o[11]),  .result(r_o[11]));
    
    PE_int8 Pe_30 (.clk(clk), .rst(rst), .x_in(x_i[3]),  .y_in(y_o[8]),  .x_out(x_o[12]), .y_out(y_o[12]), .result(r_o[12]));
    PE_int8 Pe_31 (.clk(clk), .rst(rst), .x_in(x_o[12]), .y_in(y_o[9]),  .x_out(x_o[13]), .y_out(y_o[13]), .result(r_o[13]));
    PE_int8 Pe_32 (.clk(clk), .rst(rst), .x_in(x_o[13]), .y_in(y_o[10]), .x_out(x_o[14]), .y_out(y_o[14]), .result(r_o[14]));
    PE_int8 Pe_33 (.clk(clk), .rst(rst), .x_in(x_o[14]), .y_in(y_o[11]), .x_out(x_o[15]), .y_out(y_o[15]), .result(r_o[15]));
    
    
    always @(posedge clk) begin
        
        if(rst) begin 
            for (i = 0; i < 16; i = i + 1) begin 
                out[i] <= 16'b0; 
            end 
                done      <= 1'b0;
                counter   <= 4'd0;
        end 
        else begin 
            if(counter == 4'd10) begin 
                for (k = 0; k < 16; k = k + 1) begin 
                    out[k] <= r_o[k]; 
                end 
                done    <= 1'b1; 
                counter <= 4'd0;   
            end 
            else begin 
                done    <= 1'b0; 
                counter <= counter + 1'b1; 
            end 
        end 
    end 

endmodule    
