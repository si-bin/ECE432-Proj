`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 10:11:47 PM
// Design Name: 
// Module Name: system
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


module system(
    input clk,
    input reset,
    input[7:0] PORTA,
    output[7:0] PORTB,
    output[7:0] dbusout,
    output[19:0] abus,
    output[7:0] dbusin,
    output iom,
    output notwr,
    output notrd,
    output[11:0] address_mem,
    output[7:0] i8255_dat,
    output[7:0] mem_data,
    output[12:0] latchout, input progsel);
    
    reg CPU_RESETN;
    reg[7:0] SW;
    wire[7:0] LED, o8255;
    reg clkin;
    wire[7:0] dbusout;
    wire[7:0] dbusin, mem_dat, mem_data,mem_dat_lat, i8255_dat;
    wire[19:0] abus;
    wire[11:0] address_mem;
    wire[12:0] latchout;
    wire iom, notwr, notrd, cpuerror,rdn,resoutn,wran,wrn,inta;
    
    assign address_mem = abus[11:0];
    //~notwr && iom
    //(iom + notrd)
    cpu86 core(.clk(clk), .por(reset), .abus(abus), .dbus_out(dbusout), .dbus_in(dbusin), .iom(iom), .wrn(notwr), .rdn(notrd), .nmi(1'b0), .intr(1'b0));
    //latch lat(.clk(notrd & notwr), .inputs(abus[12:0]), .outputs(latchout));
    
    //latch #(8) memlat(.clk(notrd & notwr), .inputs(mem_dat), .outputs(mem_dat_lat));
    ROM memory(.address(abus[11:0]), .data(mem_dat_lat), .psel(progsel)); 
    //assign mem_data = mem_dat;
    assign dbusin = (iom && notwr) ? (i8255_dat) : mem_dat_lat;
    //assign dbusin = mem_dat_lat;
    
    
    I82C55 PIC(.I_ADDR(address_mem[2:1]), .I_DATA(dbusout), .I_CS_L(~iom), .I_WR_L(notwr), .I_RD_L(notrd), .I_PA(PORTA), .I_PB(8'h00), .O_PB(PORTB), .I_PC(8'h00), .RESET(reset), .ENA(1'b1), .CLK(clk), .O_DATA(i8255_dat));
endmodule
