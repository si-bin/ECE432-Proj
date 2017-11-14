`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/07/2017 05:39:04 PM
// Design Name: 
// Module Name: top
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


module top(input CLK100MHZ, input CPU_RESETN, input[8:0] SW, output[7:0] LED, output[7:0] AN, output DP, output CA, output CB, output CC, output CD, output CE, output CF, output CG);
    wire CLK2MHZ;
    wire[7:0] outputB;
    wire[7:0] segs;
    assign segs = {DP, CA, CB, CC, CD, CE, CF, CG};
    assign AN = 8'hFE;
    clkdiv divider(.clk(CLK100MHZ), .modclk(CLK2MHZ));
    system sysmod(.clk(CLK2MHZ), .reset(~CPU_RESETN), .PORTA(SW[7:0]), .PORTB(outputB), .progsel(SW[8]));
    assign LED = (~SW[8]) ? outputB : 8'h00;
    assign segs = (SW[8]) ? ~outputB : 8'hFF;
endmodule
