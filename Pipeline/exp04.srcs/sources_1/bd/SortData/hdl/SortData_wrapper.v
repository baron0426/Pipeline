//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Sat Aug 31 17:08:52 2019
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
