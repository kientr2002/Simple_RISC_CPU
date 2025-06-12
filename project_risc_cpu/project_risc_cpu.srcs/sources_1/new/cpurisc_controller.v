`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/12/2025 02:40:22 PM
// Design Name: 
// Module Name: cpurisc_controller
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


module cpurisc_controller(
    input reset,
    input clk,
    input [2:0] opcode,
    output pc_enable,
    output mux_select,
    output load_ir,
    output SKZ,
    output wr_en,
    output LDA,
    output load_register,
    output JUMP,
    output imem_enable,
    output dmem_enable,
    output alu_enable,
    output acc_enable
    );
    
    reg [3:0] state;
    
    localparam  INST_ADDR   = 4'b0000, // mux selects address from PC and send to instruction memory for reading, jump to INST_FETCH
                INST_FETCH  = 4'b0001, // instruction register receive instruction and decode it to opcode and operand address, jump to INST_LOAD
                INST_LOAD   = 4'b0010, // wait for the instruction register load value and increasing PC, jump to IDLE
                IDLE        = 4'b0011, // wait for the instruction register
                OP_ADDR     = 4'b0100,
                OP_FETCH    = 4'b0101,
                ALU_OP      = 4'b0110,
                STORE       = 4'b0111,
                HALT_STATE  = 4'b1000;
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            pc_enable <= 0;
            mux_select <= 1;
            load_ir <= 0;
            SKZ <= 0;
            wr_en <= 0;
            LDA <= 0;
            load_register <= 0;
            JUMP <= 0;
            imem_enable <= 0;
            dmem_enable <= 0;
            alu_enable <= 0;
            acc_enable <= 0;
            state <= INST_ADDR;
        end
    
    end
endmodule
