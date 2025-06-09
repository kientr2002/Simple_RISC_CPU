`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/29/2025 05:02:33 PM
// Design Name: 
// Module Name: cpurisc_alu_tb
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


module cpurisc_alu_tb;
        reg [2:0] opcode; // Define Operation to execute 
        reg [7:0] accumulator_out; // InA data for caculating
        reg clk;
        reg [7:0] memory_data; // InB data for caculating
        reg alu_enable; // The switching for caculating
        wire [7:0] alu_result; // The output
        wire is_zero; // The output
        
        cpurisc_alu DUT(
            .opcode(opcode),
            .accumulator_out(accumulator_out),
            .clk(clk),
            .memory_data(memory_data),
            .alu_enable(alu_enable),
            .alu_result(alu_result),
            .is_zero(is_zero)
        );
        
        // Clock
        initial begin
            clk = 0;
            forever #5 clk = ~clk;
        end
        
        // Initial Value
        initial begin 
            opcode = 3'b000;
            accumulator_out = 8'b00000000;
            memory_data = 8'b00000000;
            alu_enable = 0;
        end
        
        // Test Sequence 
        initial begin
            #10 opcode = 3'b001; alu_enable = 1; accumulator_out = 8'b00000001; memory_data = 8'b00000000;
            #10 opcode = 3'b001; alu_enable = 0; accumulator_out = 8'b00000001; memory_data = 8'b00000000;
            #10 opcode = 3'b010; alu_enable = 1; accumulator_out = 8'b00000001; memory_data = 8'b10000000;
            #10 opcode = 3'b010; alu_enable = 1; accumulator_out = 8'b00000000; memory_data = 8'b0000000;
            #10 opcode = 3'b011; alu_enable = 1; accumulator_out = 8'b000000010; memory_data = 8'b00001001;
            #10 opcode = 3'b100; alu_enable = 1; accumulator_out = 8'b10000001; memory_data = 8'b10010000;
            #10 opcode = 3'b101; alu_enable = 1; accumulator_out = 8'b00000001; memory_data = 8'b00000000;
            #10 opcode = 3'b110; alu_enable = 1; accumulator_out = 8'b00000001; memory_data = 8'b00000000;
            #10 opcode = 3'b111; alu_enable = 1; accumulator_out = 8'b00000001; memory_data = 8'b00000000;
            #10 $finish;
        end
        
        // Display Block 
        initial begin 
            $monitor("Time=%0t | opcode=%b | acc=%b | memory_data=%b | ALU_result=%b | is_zero=%b", 
                  $time, opcode, accumulator_out, memory_data, alu_result, is_zero);
        end
endmodule
