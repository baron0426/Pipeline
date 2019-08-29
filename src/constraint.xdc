#input
set_property PACKAGE_PIN W5 [get_ports {system_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {system_clk}]
create_clock -period 10.000 -name system_clk -waveform {0.000 5.000}   [get_ports system_clk]

set_property PACKAGE_PIN V16 [get_ports {showMode[1]}]
set_property PACKAGE_PIN V17 [get_ports {showMode[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showMode[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showMode[0]}]

set_property PACKAGE_PIN T18 [get_ports {reset}]
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

set_property PACKAGE_PIN U17 [get_ports {i_clk}]
set_property IOSTANDARD LVCMOS33 [get_ports {i_clk}]

#7-Section-LEDs
set_property PACKAGE_PIN W7 [get_ports {leds[0]}]
set_property PACKAGE_PIN W6 [get_ports {leds[1]}]
set_property PACKAGE_PIN U8 [get_ports {leds[2]}]
set_property PACKAGE_PIN V8 [get_ports {leds[3]}]
set_property PACKAGE_PIN U5 [get_ports {leds[4]}]
set_property PACKAGE_PIN V5 [get_ports {leds[5]}]
set_property PACKAGE_PIN U7 [get_ports {leds[6]}]
set_property PACKAGE_PIN W4 [get_ports {led_en[3]}]
set_property PACKAGE_PIN V4 [get_ports {led_en[2]}]
set_property PACKAGE_PIN U4 [get_ports {led_en[1]}]
set_property PACKAGE_PIN U2 [get_ports {led_en[0]}]


set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_en[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_en[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_en[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_en[0]}]


#LED-Lights
set_property PACKAGE_PIN U16 [get_ports {showPC[0]}]
set_property PACKAGE_PIN E19 [get_ports {showPC[1]}]
set_property PACKAGE_PIN U19 [get_ports {showPC[2]}]
set_property PACKAGE_PIN V19 [get_ports {showPC[3]}]
set_property PACKAGE_PIN W18 [get_ports {showPC[4]}]
set_property PACKAGE_PIN U15 [get_ports {showPC[5]}]
set_property PACKAGE_PIN U14 [get_ports {showPC[6]}]
set_property PACKAGE_PIN V14 [get_ports {showPC[7]}]

set_property IOSTANDARD LVCMOS33 [get_ports {showPC[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {showPC[0]}]
