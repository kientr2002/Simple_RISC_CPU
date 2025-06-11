`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2025 05:17:58 PM
// Design Name: 
// Module Name: cpurisc_accumulator
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


module cpurisc_accumulator(
    input clk,
    input reset,
    input LDA,
    input [7:0] data_in1,
    input [7:0] data_in2,
    input acc_enable,
    input load_register,
    output [7:0] accumulator_out
    );
    
    reg [7:0] reg_accumulator_out;
    
    always @(*) begin
        if(load_register) begin
            reg_accumulator_out <= data_in1;
        end
        else if(LDA) begin
            reg_accumulator_out <= data_in2;
        end
        else begin
            reg_accumulator_out <= accumulator_out;
        end
    end
    
    always @(posedge clk) begin
        if(reset) begin
            accumulator_out <= 8'b00000000;
        end
        else if(acc_enable) begin
            accumulator_out <= reg_accumulator_out;
        end
    end
endmodule
