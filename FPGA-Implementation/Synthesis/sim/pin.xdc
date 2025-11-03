
## Clock input
set_property PACKAGE_PIN Y9 [get_ports clk_in]
set_property IOSTANDARD LVCMOS33 [get_ports clk_in]
create_clock -period 10.000 -name sys_clk_pin -waveform {0.000 5.000} -add [get_ports clk_in]

## Reset button (BTNC - Center button)
set_property PACKAGE_PIN P16 [get_ports reset_n_in]
set_property IOSTANDARD LVCMOS33 [get_ports reset_n_in]
set_property PULLDOWN true [get_ports reset_n_in]

## Timing constraints
set_input_delay -clock sys_clk_pin -min 0.000 [get_ports reset_n_in]
set_input_delay -clock sys_clk_pin -max 2.000 [get_ports reset_n_in]
set_false_path -from [get_ports reset_n_in] -to [all_registers]


## Bitstream configuration
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLDOWN [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
