vlib work
vlib riviera

vlib riviera/dist_mem_gen_v8_0_12
vlib riviera/xil_defaultlib

vmap dist_mem_gen_v8_0_12 riviera/dist_mem_gen_v8_0_12
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work dist_mem_gen_v8_0_12  -v2k5 \
"../../../../exp04.srcs/sources_1/bd/SortData/ipshared/d46a/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib  -v2k5 \
"../../../bd/SortData/ip/SortData_dist_mem_gen_0_0/sim/SortData_dist_mem_gen_0_0.v" \
"../../../bd/SortData/sim/SortData.v" \

vlog -work xil_defaultlib \
"glbl.v"

