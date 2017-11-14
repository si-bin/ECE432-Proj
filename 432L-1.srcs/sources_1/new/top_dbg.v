`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2017 08:03:20 PM
// Design Name: 
// Module Name: top_dbg
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


module top_dbg();
    reg CPU_RESETN;
    reg[7:0] SW;
    wire[7:0] LED, o8255;
    reg clkin;
    wire[7:0] dbusout;
    wire[7:0] dbusin, memdat, i8255_data;
    wire[19:0] abus;
    wire[11:0] address_mem;
    wire iom, notwr, notrd, cpuerror,rdn,resoutn,wran,wrn,inta;
    reg nmi, intr;
    wire[12:0] latchout;
    wire[1:0] ctrl;
    assign ctrl = address_mem[2:1];
    initial begin
        SW = 8'h3;
        nmi = 1'b0;
        intr = 1'b0;
        clkin = 1'b0;
        CPU_RESETN = 1'b0;
        #40 CPU_RESETN = 1'b1;
        #100 CPU_RESETN = 1'b0;
    end

    always begin
        #5 clkin = ~clkin;
    end
    
    //wire CLK2MHZ;
    //clkdiv divider(.clk(clkin), .modclk(CLK2MHZ));
    system sysdbg(.clk(clkin), .reset(CPU_RESETN), .PORTA(SW), .PORTB(LED), .dbusout(dbusout), .abus(abus), .dbusin(dbusin), .iom(iom), .notwr(notwr), .notrd(notrd), .address_mem(address_mem),
    .i8255_dat(o8255), .mem_data(memdat), .latchout(latchout));
    //cpu86 sysdbg(.clk(clkin), .dbus_in(dbusin), .intr(intr), .nmi(nmi), .por(CPU_RESETN), .abus(abus), .dbus_out(dbusout), .cpuerror(cpuerror), .inta(inta), .rdn(rdn), .resoutn(resoutn), .wran(wran), .wrn(wrn));
endmodule
