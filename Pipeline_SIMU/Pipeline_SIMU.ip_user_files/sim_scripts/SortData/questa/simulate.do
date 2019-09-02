onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib SortData_opt

do {wave.do}

view wave
view structure
view signals

do {SortData.udo}

run -all

quit -force
