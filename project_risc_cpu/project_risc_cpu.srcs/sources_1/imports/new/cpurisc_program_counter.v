`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 08:37:20 PM
// Design Name: 
// Module Name: cpurisc_program_counter
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


module cpurisc_program_counter(
    input wire SKZ, 
    input wire JUMP,
    input wire is_zero,
    input wire clk,
    input wire [4:0] PC_jump_addr,
    input wire reset,
    input wire pc_enable,
    output reg [4:0] PC_out
    );
    wire [4:0] pc_jump;
    assign pc_jump = (JUMP) ? PC_jump_addr : (SKZ && is_zero) ? is_zero + 2 : (pc_enable) ? PC_out + 1: PC_out;// Determine the next address based on JUMP and SKZ signals

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            PC_out <= 5'b00000;         // Reset the program counter to 0
        end else if (pc_enable) begin
        $monitor("runnning %b",pc_jump);
           PC_out <= pc_jump;         // Update the program counter if inc_pc is high
        end
    end
    
endmodule



