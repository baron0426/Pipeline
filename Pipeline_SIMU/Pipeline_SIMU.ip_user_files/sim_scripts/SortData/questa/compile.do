vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/dist_mem_gen_v8_0_12
vlib questa_lib/msim/xil_defaultlib

vmap dist_mem_gen_v8_0_12 questa_lib/msim/dist_mem_gen_v8_0_12
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work dist_mem_gen_v8_0_12 -64 \
"../../../../exp04.srcs/sources_1/bd/SortData/ipshared/d46a/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib -64 \
"../../../bd/SortData/ip/SortData_dist_mem_gen_0_0/sim/SortData_dist_mem_gen_0_0.v" \
"../../../bd/SortData/sim/SortData.v" \

vlog -work xil_defaultlib \
"glbl.v"

