//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.3 (win64) Build 2405991 Thu Dec  6 23:38:27 MST 2018
//Date        : Fri Aug 30 20:26:42 2019
//Host        : DESKTOP-HIS8ABG running 64-bit major release  (build 9200)
//Command     : generate_target SortData.bd
//Design      : SortData
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "SortData,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=SortData,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=0,numHierBlks=0,maxHierDepth=0,numSysgenBlks=0,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=USER,synth_mode=Global}" *) (* HW_HANDOFF = "SortData.hwdef" *) 
module SortData
   (Address,
    MemOut);
  input [7:0]Address;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.MEMOUT DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.MEMOUT, LAYERED_METADATA undef" *) output [31:0]MemOut;

  wire [7:0]Address_1;
  wire [31:0]dist_mem_gen_0_spo;

  assign Address_1 = Address[7:0];
  assign MemOut[31:0] = dist_mem_gen_0_spo;
  SortData_dist_mem_gen_0_0 dist_mem_gen_0
       (.a(Address_1),
        .spo(dist_mem_gen_0_spo));
endmodule
