# ECE495-LAB7-cpu
work in progress

.mif files used in Quartus for editing
.hex files derived from .mif files used for Modelsim simulations

Component Hierarchy:

TOP_LEVEL: top_level.vhd
  - DISPLAY: display.vhd
  - CPU: cpu.vhd
  - RAM: lpm_ram_dq
  
CPU: cpu.vhd
  - MICROSEQUENCER: exp7_useq.vhd (provided)
  - REG_SECTION: reg_file.vhd
  
REG_SECTION: reg_file.vhd
  - ALU: exp7_alu.vhd (provided)
  - MUX: lpm_mux
  - REG: lpm_ff
  - COUNTER: lpm_counter
  
