# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcpg236-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/Baron/Pipeline/Pipeline/exp04.cache/wt [current_project]
set_property parent.project_path D:/Baron/Pipeline/Pipeline/exp04.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo d:/Baron/Pipeline/Pipeline/exp04.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
add_files D:/Baron/Pipeline/Pipeline/SortData_dist_mem_gen_0_0.coe
add_files D:/Baron/Pipeline/Pipeline/exp04.srcs/sources_1/bd/SortData/ip/SortData_dist_mem_gen_0_0/123.coe
read_verilog -library xil_defaultlib {
  D:/Baron/Pipeline/Pipeline/src/ALU.v
  D:/Baron/Pipeline/Pipeline/src/ALUControl.v
  D:/Baron/Pipeline/Pipeline/src/Control.v
  D:/Baron/Pipeline/Pipeline/src/DataMemory.v
  D:/Baron/Pipeline/Pipeline/src/EX.v
  D:/Baron/Pipeline/Pipeline/src/Forward.v
  D:/Baron/Pipeline/Pipeline/src/ID.v
  D:/Baron/Pipeline/Pipeline/src/IF.v
  D:/Baron/Pipeline/Pipeline/src/InstructionMemory.v
  D:/Baron/Pipeline/Pipeline/src/MEM.v
  D:/Baron/Pipeline/Pipeline/src/PC.v
  D:/Baron/Pipeline/Pipeline/src/RegisterFile.v
  D:/Baron/Pipeline/Pipeline/src/StateRegisters.v
  D:/Baron/Pipeline/Pipeline/src/WB.v
  D:/Baron/Pipeline/Pipeline/src/hazardjump.v
  D:/Baron/Pipeline/Pipeline/src/CPU.v
}
add_files D:/Baron/Pipeline/Pipeline/exp04.srcs/sources_1/bd/SortData/SortData.bd
set_property used_in_implementation false [get_files -all d:/Baron/Pipeline/Pipeline/exp04.srcs/sources_1/bd/SortData/ip/SortData_dist_mem_gen_0_0/SortData_dist_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all D:/Baron/Pipeline/Pipeline/exp04.srcs/sources_1/bd/SortData/SortData_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]
set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top CPU -part xc7a35tcpg236-3


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef CPU.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file CPU_utilization_synth.rpt -pb CPU_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]