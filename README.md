# ECE495-LAB7-cpu

Environment: Quartus II, Modelsim

Hardware: Altera DE2 FPGA (Cyclone II 2C35, EP2C35F672C6)

12/9/2019 : passed all 12 test programs in simulation and on FPGA

Instruction Set: (refer to doc/instruction_set.pdf)

RTL Instruction List: (refer to doc/rtl.pdf)

Microsequencer Microcode: (refer to doc/microcode.pdf)

Block Diagrams: https://imgur.com/a/GFWdIvJ.png

Testbench Waveform of a POP instruction routine: https://i.imgur.com/m09x5u9.png

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
