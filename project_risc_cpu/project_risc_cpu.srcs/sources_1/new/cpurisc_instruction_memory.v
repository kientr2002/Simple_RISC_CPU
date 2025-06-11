`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/11/2025 04:27:54 PM
// Design Name: 
// Module Name: cpurisc_instruction_memory
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


module cpurisc_instruction_memory(
    input wire clk,
    input wire [4:0] instruction_address,
    input wire imem_enable,
    output reg [7:0] instruct
    );
    reg [7:0]instruction_mem[31:0];
    
    initial begin
        $readmemb("instruction_file.mem",instruction_mem);
    end
    always@(posedge clk) begin
        if(imem_enable) begin
            instruct <= instruction_mem[instruction_address];
        end
    end
endmodule
