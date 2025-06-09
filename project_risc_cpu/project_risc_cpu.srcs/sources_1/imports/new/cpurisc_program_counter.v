`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/08/2025 08:37:20 PM
// Design Name: 
// Module Name: cpurisc_program_counter
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


module cpurisc_program_counter(
    input wire clk, // positive edge 
    input wire [4:0] input_number,
    input wire reset, // positive level
    input wire enable_loading, // positive level
    input wire enable_counting, // positive level
    output reg [4:0] output_counter
    );
    reg [4:0] reg_counter = 5'b00000;

    always @(posedge clk) begin
        $monitor("reg_counter: %b", reg_counter);
        if (reset == 1) 
            reg_counter <= 5'b00000;  // reset logic
        else if (enable_loading == 1) 
            reg_counter <= input_number; // load input value
        else if (enable_counting == 1) 
            reg_counter <= reg_counter + 1; // count logic
    end

    // Output assignment
    always @(posedge clk) begin
        output_counter <= reg_counter;
    end
    
endmodule
