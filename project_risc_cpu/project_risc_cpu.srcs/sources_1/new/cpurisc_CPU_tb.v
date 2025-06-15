`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2025 03:09:53 PM
// Design Name: 
// Module Name: cpurisc_CPU_tb
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


module cpurisc_CPU_tb;

     reg clk;
     reg reset;
     wire [4:0] PC_out;
     wire [4:0]operand_address_out;
     wire [4:0]instruction_address;
     wire [7:0] instruct;
     wire [2:0] opcode;
     wire [4:0] operand_addr;
     wire [4:0] PC_jump_addr;
     wire [7:0] accumulator_out;
     wire [7:0] memory_data;
     wire [7:0] alu_result;
     wire is_zero;
     wire pc_enable;
     wire mux_select;
     wire load_ir;
     wire SKZ;
     wire wr_en;
     wire JUMP;
     wire imem_enable;
     wire alu_enable;
     wire acc_enable;
     wire [3:0] state;
    cpurisc_CPU CPU_UUT(
        .clk(clk),
        .reset(reset),
        .PC_out(PC_out),
        .operand_address_out(operand_address_out),
        .instruction_address(instruction_address),
        .instruct(instruct),
        .opcode(opcode),
        .operand_addr(operand_addr),
        .PC_jump_addr(PC_jump_addr),
        .accumulator_out(accumulator_out),
        .memory_data(memory_data),
        .alu_result(alu_result),
        .is_zero(is_zero),
        .pc_enable(pc_enable),
        .mux_select(mux_select),
        .load_ir(load_ir),
        .SKZ(SKZ),
        .wr_en(wr_en),
        .JUMP(JUMP),
        .imem_enable(imem_enable),
        .alu_enable(alu_enable),
        .acc_enable(acc_enable),
        .state(state)
    ); 
    initial begin
        clk = 0;
        forever #1 clk = ~clk; // Clock with 10ns period
    end

    // Test sequence
    initial begin
        reset = 1;
        #3 reset = 0;
        #3000;
        $finish;
    end

    initial begin
        $monitor(
            "%0t | PC_out=%0d operand_address_out=%0d instruction_address=%0d instruct=0x%0h opcode=%b operand_addr=%0d PC_jump_addr=%0d accumulator_out=0x%0h memory_data=0x%0h alu_result=0x%0h is_zero=%b pc_enable=%b mux_select=%b load_ir=%b SKZ=%b wr_en=%b JUMP=%b imem_enable=%b alu_enable=%b acc_enable=%b state=%b",
            $time,
            PC_out,
            operand_address_out,
            instruction_address,
            instruct,
            opcode,
            operand_addr,
            PC_jump_addr,
            accumulator_out,
            memory_data,
            alu_result,
            is_zero,
            pc_enable,
            mux_select,
            load_ir,
            SKZ,
            wr_en,
            JUMP,
            imem_enable,
            alu_enable,
            acc_enable,
            state
        );
    end

endmodule     

