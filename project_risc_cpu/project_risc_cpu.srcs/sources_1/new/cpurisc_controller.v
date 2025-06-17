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
    input wire reset,
    input wire clk,
    input wire [2:0] opcode,
    output reg pc_enable,
    output reg mux_select,
    output reg load_ir,
    output reg SKZ,
    output reg wr_en,
    output reg JUMP,
    output reg imem_enable,
    output reg alu_enable,
    output reg acc_enable,
    output reg [3:0] state
    );
    
    
    localparam  SELECT_INST_ADDR   = 4'b0000, // mux selects address from PC and send to instruction memory for reading, 
                                              // jump to INST_FETCH
                                              
                INST_FETCH  = 4'b0001, // instruction memory receive instruction address and send instruction to instruction register, 
                                       // jump to INST_LOAD
                                       
                INST_DECODE   = 4'b0010, // instruction register decode instruction (opcode and operand address), 
                                       // send opcode to controller and ALU; operand address for address mux,
                                       // jump to OPCODE_PROCESSING
                                       
                OPCODE_PROCESSING        = 4'b0011, // controller reads the opcode, the next action will be happened in the next state,
                                                    // address mux send the operand address to data memory for pre-caculating and the program counter for jumping if any,
                                                    // jump to OP_ADDR
                                       
                OPCODE_OPERATION     = 4'b0100, // based on opcode, ALU will be operation 
                                                // if opcode is HALT_STATE, also be happened on this state
                                                // jump to OPCODE_ACCUMULATOR   
                
                OPCODE_ACCUMULATOR    = 4'b0101, // accumulator will be received data from ALU
                                                 // jump to OPCODE_MEMORYANDPC
                
                OPCODE_MEMORYANDPC      = 4'b0110, // memory and PC (relevant to JUMP or SKZ) will be active on this state
                                                   // jump to STORE
                
                PC_PROCESSING       = 4'b0111, // Program Counter will caculate the next address and also send data to Data Memory 
                                               // jump to SELECT_INST_ADDR
                                        
                HALT_STATE  = 4'b1000; // nothing happen, back to SELECT_INST_ADDR if having the reset signal
    
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            pc_enable <= 0;
            mux_select <= 1;
            load_ir <= 0;
            SKZ <= 0;
            wr_en <= 0;
            JUMP <= 0;
            imem_enable <= 0;
            alu_enable <= 0;
            acc_enable <= 0;
            state <= SELECT_INST_ADDR;
        end
        else begin
            case(state)
                SELECT_INST_ADDR: begin
                    pc_enable <= 0;
                    mux_select <= 1;
                    load_ir <= 0;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0;
                    imem_enable <= 1;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= INST_FETCH;                   
                end 
                INST_FETCH: begin
                    pc_enable <= 0;
                    mux_select <= 1;
                    load_ir <= 1;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0;
                    imem_enable <= 1;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= INST_DECODE;                   
                end 
                INST_DECODE: begin
                    pc_enable <= 0;
                    mux_select <= 1;
                    load_ir <= 1;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0;
                    imem_enable <= 1;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= OPCODE_PROCESSING;                    
                end 
                OPCODE_PROCESSING: begin
                    pc_enable <= 0;
                    mux_select <= 0;
                    load_ir <= 0;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0;
                    imem_enable <= 0;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= OPCODE_OPERATION;                   
                end 
                OPCODE_OPERATION: begin 
                    if(opcode == 3'b000) begin
                        pc_enable <= 0;
                        mux_select <= 0;
                        load_ir <= 0;
                        SKZ <= 0;
                        wr_en <= 0;
                        JUMP <= 0;
                        imem_enable <= 0;
                        alu_enable <= 0;
                        acc_enable <= 0;
                        state <= HALT_STATE;
                    end   
                    else begin
                        pc_enable <= 0;
                        mux_select <= 0;
                        load_ir <= 0;
                        SKZ <= (opcode == 3'b001);
                        wr_en <= 0;
                        JUMP <= (opcode == 3'b111); 
                        imem_enable <= 0;
                        alu_enable <= (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101);
                        acc_enable <= 0;
                        state <= OPCODE_ACCUMULATOR;
                    end                 
                end 
                OPCODE_ACCUMULATOR: begin
                    pc_enable <= 0;
                    mux_select <= 0;
                    load_ir <= 0;
                    SKZ <= (opcode == 3'b001);
                    wr_en <= 0;
                    JUMP <= (opcode == 3'b111); 
                    imem_enable <= 0;
                    alu_enable <= (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101);
                    acc_enable <= (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101);
                    state <= OPCODE_MEMORYANDPC;                
                end 
                OPCODE_MEMORYANDPC: begin
                    pc_enable <= (opcode == 3'b001 || opcode == 3'b111);
                    mux_select <= 0;
                    load_ir <= 0;
                    SKZ <= (opcode == 3'b001);
                    wr_en <= (opcode == 3'b110);
                    JUMP <= (opcode == 3'b111); 
                    imem_enable <= 0;
                    alu_enable <= 0;
                    acc_enable <= (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101);
                    state <= PC_PROCESSING;                                
                end 
                PC_PROCESSING: begin
                    pc_enable <= (opcode == 3'b010 || opcode == 3'b011 || opcode == 3'b100 || opcode == 3'b101|| opcode == 3'b110);
                    mux_select <= 1;
                    load_ir <= 0;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0; 
                    imem_enable <= 0;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= SELECT_INST_ADDR;                   
                end 
                
                HALT_STATE: begin 
                    pc_enable <= 0;
                    mux_select <= 0;
                    load_ir <= 0;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0;
                    imem_enable <= 0;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= HALT_STATE;                
                end
                
                default: begin
                    pc_enable <= 0;
                    mux_select <= 0;
                    load_ir <= 0;
                    SKZ <= 0;
                    wr_en <= 0;
                    JUMP <= 0;
                    imem_enable <= 0;
                    alu_enable <= 0;
                    acc_enable <= 0;
                    state <= SELECT_INST_ADDR;                
                end
            endcase
        end
    end
endmodule
