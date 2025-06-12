`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 03:04:28 PM
// Design Name: 
// Module Name: cpurisc_alu
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


module cpurisc_alu(
        input wire [2:0] opcode, // Define Operation to execute 
        input wire [7:0] accumulator_out, // InA data for caculating
        input wire clk,
        input wire [7:0] memory_data, // InB data for caculating
        input wire alu_enable, // The switching for caculating
        output reg [7:0] alu_result, // The output
        output reg is_zero // The output
    );
    
    
    reg [7:0] alu_nextResult;
    
    // opcode operation 
    always@(*) begin 
        if(alu_enable == 1) begin
            // Change the value based on the operation code 
            case(opcode)
                3'b010: alu_nextResult <= accumulator_out + memory_data;// ADD 
                3'b011: alu_nextResult <= accumulator_out & memory_data;// AND 
                3'b100: alu_nextResult <= accumulator_out ^ memory_data;// XOR
                3'b101: alu_nextResult <= memory_data; // Read memory data and send it to accumulator
                default: alu_nextResult <= alu_result;
            endcase
        end
        else begin
            // Keep the old value
            alu_nextResult <= alu_result;
        end
    end
    
    
    // Output alu_result Processing 
    always@(posedge clk) begin
        if(alu_enable == 1)
            alu_result <= alu_nextResult;
    end
    
    // Output is_zero Processing 
    always@(*) begin
        if(alu_result == 8'b0)
            is_zero = 1'b1;
        else
            is_zero = 1'b0;
    end
endmodule
