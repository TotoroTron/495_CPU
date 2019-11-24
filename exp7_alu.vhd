-- ECE 495 Exp. 7
-- 8-bit ALU
-- Filename: exp7_alu.vhd
-- Dr. Hou
--
-- result <= a + b,   if op = 0
--        <= a xor b, if op = 1
--
library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity exp7_alu is
port (a, b: in std_logic_vector(7 downto 0);
      op: in std_logic_vector(0 downto 0);   
      result: out std_logic_vector(7 downto 0));
end exp7_alu;

architecture structural of exp7_alu is
signal add_result, xor_result: std_logic_vector(7 downto 0);
signal mux_data: std_logic_2D(1 downto 0, 7 downto 0);
begin

	ALU_ADDER: lpm_add_sub
		generic map (lpm_width=>8)
		port map (
			dataa => a,
			datab => b,
			result => add_result
	);
	
	xor_result <= a xor b;
  
	GEN_MUX: for i in 7 downto 0 generate
		mux_data(0,i) <= add_result(i);
		mux_data(1,i) <= xor_result(i);
	end generate;
  
	ALU_MUX: lpm_mux
		generic map (
			lpm_width => 8,
			lpm_size => 2,
			lpm_widths => 1
		) port map (
			data => mux_data,
			result => result,
			sel => op
	);
	
end structural;

