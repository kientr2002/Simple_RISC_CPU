`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/15/2025 09:52:10 AM
// Design Name: 
// Module Name: cpurisc_CPU
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


module cpurisc_CPU(
    input wire clk,
    input wire reset,
    output wire [4:0] PC_out,
    output wire [4:0]operand_address_out,
    output wire [4:0]instruction_address,
    output wire [7:0] instruct,
    output wire [2:0] opcode,
    output wire [4:0] operand_addr,
    output wire [4:0] PC_jump_addr,
    output wire [7:0] accumulator_out,
    output wire [7:0] memory_data,
    output wire [7:0] alu_result,
    output wire is_zero,
    output wire pc_enable,
    output wire mux_select,
    output wire load_ir,
    output wire SKZ,
    output wire wr_en,
    output wire JUMP,
    output wire imem_enable,
    output wire alu_enable,
    output wire acc_enable,
    output wire [3:0] state
    
    );

    
    cpurisc_controller CTRL(
        .clk(clk),
        .reset(reset),
        .opcode(opcode),               
        .pc_enable(pc_enable),            
        .mux_select(mux_select),      
        .load_ir(load_ir),            
        .wr_en(wr_en),                           
        .acc_enable(acc_enable),                
        .JUMP(JUMP),                   
        .imem_enable(imem_enable),    
        .alu_enable(alu_enable),       
        .state(state),                 
        .SKZ(SKZ)                    
    );
    
    // Program Counter
    cpurisc_program_counter PC (
        .clk(clk),
        .reset(reset),
        .pc_enable(pc_enable),            // Đổi tên để đồng bộ
        .is_zero(is_zero),
        .SKZ(SKZ),                     // Tín hiệu SKZ từ Controller
        .JUMP(JUMP),                    // Đổi tên để đồng bộ
        .PC_jump_addr(operand_address_out),   // Địa chỉ nhảy từ Instruction Register
        .PC_out(PC_out)
    );

    // Address MUX
    cpurisc_address_mux AMUX (
        .PC_out(PC_out),
        .operand_address_in(operand_addr),
        .mux_select(mux_select),
        .instruction_address(instruction_address),
        .operand_address_out(operand_address_out),
        .clk(clk)
    );

    // Instruction Memory with enable
    cpurisc_instruction_memory IMEM (
        .clk(clk),
        .imem_enable(imem_enable),
        .instruction_address(instruction_address),
        .instruct(instruct)
    );

    // Instruction Register
    cpurisc_instruction_register IR (
        .clk(clk),
        .reset(reset),
        .load_ir(load_ir),
        .instruct(instruct),
        .opcode(opcode),
        .operand_addr(operand_addr)
    );

    // Data Memory
    cpurisc_dataMemory DMEM (
        .clk(clk),
        .addr(operand_address_out),
        .accumulator_out(accumulator_out),
        .memory_data(memory_data),
        .wr_en(wr_en)
    );

    // ALU with enable
    cpurisc_alu ALU (
        .clk(clk),
        .alu_enable(alu_enable),
        .opcode(opcode),
        .memory_data(memory_data),
        .accumulator_out(accumulator_out),
        .alu_result(alu_result),
        .is_zero(is_zero)
    );

    // Accumulator Register
    cpurisc_accumulator ACC (
        .clk(clk),
        .reset(reset),
        .acc_enable(acc_enable),
        .ALU_result(alu_result),
        .accumulator_out(accumulator_out)
    );
    
    
endmodule
