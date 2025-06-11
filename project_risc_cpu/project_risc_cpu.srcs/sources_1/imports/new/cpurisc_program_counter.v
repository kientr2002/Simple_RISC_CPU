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
    reg [4:0] reg_counter = 5'b00000;

    
    always @(*) begin
        if(pc_enable) begin
            if(SKZ == 1 && is_zero == 1)
                reg_counter <= PC_out + 5'b00010; // skipping the next instruction 
             else if(JUMP == 1)
                reg_counter <= PC_jump_addr; // jumping to the specific instruction
             else
                reg_counter <= PC_out + 5'b00001; // normal mode
                
        end
        else 
            reg_counter <= PC_out;
    end
    
    
    always @(posedge clk) begin 
    if(reset)
        PC_out <= 5'b00000;
    else if(pc_enable)
        PC_out <= reg_counter;
    end
    
endmodule



