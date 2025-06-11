`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2025 04:54:20 PM
// Design Name: 
// Module Name: cpurisc_instruction_register
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


module cpurisc_instruction_register(
    input wire [7:0] instruct,
    input wire clk,
    input wire reset,
    input wire load_ir,
    output reg [2:0] opcode,
    output reg [4:0] operand_address
    );
    
    reg [2:0] reg_opcode;
    reg [4:0] reg_operand_address;
    
    always @(*) begin
        if(load_ir) begin
            reg_opcode <= instruct[7:5];
            reg_operand_address <= instruct[4:0];
         end
         else begin
            reg_opcode <= opcode;
            reg_operand_address <= operand_address;
         end
    end
    
    
    always @(posedge clk) begin
        if(reset) begin
            opcode <= 3'b000;
            operand_address <= 5'b00000;
        end
        else begin
            opcode <= reg_opcode;
            operand_address <= reg_operand_address;          
        end
    end
endmodule
