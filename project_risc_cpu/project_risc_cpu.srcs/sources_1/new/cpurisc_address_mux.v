`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/10/2025 03:37:24 PM
// Design Name: 
// Module Name: cpurisc_address_mux
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


module cpurisc_address_mux(
        input wire [4:0]PC_out,
        input wire [4:0]operand_address_in,
        input wire clk,
        input wire mux_select,
        output reg [4:0]operand_address_out,
        output reg [4:0]instruction_address
    );
    
    always@(posedge clk) begin
        if(mux_select) 
        // if mux_select is 0, instruction memory will receive the address of output counter for decoding in the next step
        // if mux_select is 1, data memory will get operand address for caculating.
            operand_address_out <= operand_address_in;
        else
            instruction_address <= PC_out;
    end 
endmodule
