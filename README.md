# ECE495-LAB7-cpu

12/9/2019 : passed all 12 test programs in simulation and on FPGA

Component Hierarchy:

TOP_LEVEL: top_level.vhd
  - DISPLAY: display.vhd
  - CPU: cpu.vhd
  - RAM: lpm_ram_dq (built-in)
  
CPU: cpu.vhd
  - MICROSEQUENCER: exp7_useq.vhd (provided)
  - REG_SECTION: reg_file.vhd
  
REG_SECTION: reg_file.vhd
  - ALU: exp7_alu.vhd (provided)
  - MUX: lpm_mux (built-in)
  - REG: lpm_ff (built-in)
  - COUNTER: lpm_counter (built-in)