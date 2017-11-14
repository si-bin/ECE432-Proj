`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 11:20:27 PM
// Design Name: 
// Module Name: latch
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


module latch(input clk, input[width-1:0] inputs, output[width-1:0] outputs);
parameter width = 13;
    reg[width-1:0] data;
    assign outputs = data;
    always @(posedge clk) begin
        data <= inputs;
    end
endmodule
