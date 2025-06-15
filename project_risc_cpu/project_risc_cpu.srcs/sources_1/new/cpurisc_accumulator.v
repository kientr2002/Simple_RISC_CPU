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
    input wire clk,
    input wire reset,
    input wire [7:0] ALU_result,
    input wire acc_enable,
    output reg [7:0] accumulator_out
    );
    
    reg [7:0] reg_accumulator_out;
    
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            accumulator_out <= 8'b00000000;
        end
        else if(acc_enable) begin
            accumulator_out <= ALU_result;
        end
    end
endmodule
