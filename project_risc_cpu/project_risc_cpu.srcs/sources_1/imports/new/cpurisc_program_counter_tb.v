`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/09/2025 04:36:18 PM
// Design Name: 
// Module Name: cpurisc_program_counter_tb
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


module cpurisc_program_counter_tb;
    reg clk; // positive edge 
    reg [4:0] input_number;
    reg reset; // positive level
    reg enable_loading; // positive level
    reg enable_counting; // positive level
    wire [4:0] output_counter;
    
    cpurisc_program_counter UUT(
    .clk(clk),
    .input_number(input_number),
    .reset(reset),
    .enable_loading(enable_loading),
    .enable_counting(enable_counting),
    .output_counter(output_counter)
    );
    
    initial begin
        clk = 0;
        input_number = 5'b00000;
        reset = 0;
        enable_loading = 0;
        enable_counting = 0;
    end
    
    initial begin
        forever #5 clk = ~clk;
    end

    initial begin
        forever #10 enable_counting = ~enable_counting;
    end    

    initial begin
        #20 input_number = 5'b00001;
        #30 enable_loading = 1;
        #10 enable_loading = 0;
        #50 reset = 1;
        #20 reset = 0;
        
        
    end
    
    initial begin
        $monitor("time:%0t, input_number:%b, reset:%b, enable_loading:%b, enable_counting:%b, output_counter:%b", $time, input_number, reset, enable_loading, enable_counting, output_counter);
    end
endmodule
