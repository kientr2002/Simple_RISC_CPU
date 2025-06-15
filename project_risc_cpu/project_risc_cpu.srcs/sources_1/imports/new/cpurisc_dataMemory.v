`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 06:17:54 PM
// Design Name: 
// Module Name: cpurisc_dataMemory
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


module cpurisc_dataMemory(
    input wire clk,
    input wire wr_en,
    input wire [4:0] addr,
    input wire [7:0] accumulator_out,
    output reg [7:0] memory_data 
    );
    
    reg [7:0] instruction_mem [31:0];
    
    initial begin
        $readmemb("instruction_file.mem",instruction_mem);
    end

    
    always @(posedge clk) begin
        if(wr_en) begin // write mode
            instruction_mem[addr] <= accumulator_out;
        end
        else begin // read mode
            memory_data  <= instruction_mem[addr];
        end
    end
endmodule
