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
    input wire dmem_enable,
    input wire clk,
    input wire wr_en,
    input wire [4:0] addr,
    input wire [7:0] write_data,
    output reg [7:0] read_data
    );
    
    reg [7:0] instruction_mem [31:0];
    
    initial begin
        $readmemb("instruction_file.mem",instruction_mem);
    end

    
    always @(posedge clk) begin
        if(dmem_enable) begin
            if(wr_en) begin // write mode
                instruction_mem[addr] <= write_data;
            end
            else begin // read mode
                read_data <= instruction_mem[addr];
            end
        end
    end
endmodule
