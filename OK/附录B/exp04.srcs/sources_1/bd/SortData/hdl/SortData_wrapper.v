//Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
//Date        : Mon Sep  2 12:51:55 2019
//Host        : DESKTOP-HIS8ABG running 64-bit major release  (build 9200)
//Command     : generate_target SortData_wrapper.bd
//Design      : SortData_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module SortData_wrapper
   (Address,
    MemOut);
  input [7:0]Address;
  output [31:0]MemOut;

  wire [7:0]Address;
  wire [31:0]MemOut;

  SortData SortData_i
       (.Address(Address),
        .MemOut(MemOut));
endmodule
