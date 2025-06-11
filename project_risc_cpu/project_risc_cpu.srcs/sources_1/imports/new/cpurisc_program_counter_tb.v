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
    // Inputs to DUT
    reg SKZ;
    reg JUMP;
    reg is_zero;
    reg clk;
    reg reset;
    reg pc_enable;
    reg [4:0] PC_jump_addr;
    // Output from DUT
    wire [4:0] PC_out;

    // Instantiate the Unit Under Test (UUT)
    cpurisc_program_counter uut (
        .SKZ(SKZ),
        .JUMP(JUMP),
        .is_zero(is_zero),
        .clk(clk),
        .PC_jump_addr(PC_jump_addr),
        .reset(reset),
        .pc_enable(pc_enable),
        .PC_out(PC_out)
    );

    // Clock generation: 10 ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        //--------------------------------------------------------------------------
        // 1) Apply reset
        //--------------------------------------------------------------------------
        SKZ          = 0;
        JUMP         = 0;
        is_zero      = 0;
        PC_jump_addr = 5'd0;
        pc_enable    = 0;
        reset        = 1;
        #12;               // wait >1 clock
        reset        = 0;  // release reset
        #8;

        //--------------------------------------------------------------------------
        // 2) Normal increment: PC_out should go 0→1→2
        //--------------------------------------------------------------------------
        pc_enable = 1;
        #10;  $display("Time=%0t  Normal:   PC_out = %0d", $time, PC_out);
        #10;  $display("Time=%0t  Normal:   PC_out = %0d", $time, PC_out);

        //--------------------------------------------------------------------------
        // 3) SKZ skip: when SKZ=1 & is_zero=1 should skip +2
        //    e.g., from PC_out=2 → 4
        //--------------------------------------------------------------------------
        SKZ     = 1;
        is_zero = 1;
        #10;  $display("Time=%0t  SKZ skip: PC_out = %0d", $time, PC_out);
        SKZ     = 0;
        is_zero = 0;

        //--------------------------------------------------------------------------
        // 4) JUMP: when JUMP=1 should load PC_jump_addr
        //    e.g., set PC_jump_addr=10 → PC_out=10
        //--------------------------------------------------------------------------
        PC_jump_addr = 5'd10;
        JUMP         = 1;
        #10;  $display("Time=%0t  Jump:     PC_out = %0d", $time, PC_out);
        JUMP = 0;

        //--------------------------------------------------------------------------
        // 5) Disable: pc_enable=0 → PC_out holds its value
        //--------------------------------------------------------------------------
        pc_enable = 0;
        #10;  $display("Time=%0t  Disabled: PC_out = %0d", $time, PC_out);
        #10;  $display("Time=%0t  Disabled: PC_out = %0d", $time, PC_out);
        
        //--------------------------------------------------------------------------
        // 6)  Enable normal mode again
        //--------------------------------------------------------------------------
        pc_enable = 1;
        #10;  $display("Time=%0t  Disabled: PC_out = %0d", $time, PC_out);
        #10;  $display("Time=%0t  Disabled: PC_out = %0d", $time, PC_out);        
        
        //--------------------------------------------------------------------------
        // 7) Reset again
        //--------------------------------------------------------------------------
        #10 reset = 1;
        #20  reset = 0;
        #10;  $display("Time=%0t  Disabled: PC_out = %0d", $time, PC_out);
        #10;  $display("Time=%0t  Disabled: PC_out = %0d", $time, PC_out);        
        $finish;
    end
endmodule
