library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;
use work.all;

entity reg_file is
	port(
		clk : in std_logic;
		uOps : in std_logic_vector(29 downto 9); --from useq
		M_q : in std_logic_vector(7 downto 0); --from ram
		M_addr : out std_logic_vector(7 downto 0) --to ram
	);
end entity;

architecture structural of reg_file is
	--register outputs
	signal M_q, SP_q, PC_q, opcode, DR_q, R_q, A_q : std_logic_vector(7 downto 0);
	--register loads
	signal MARLOAD, SPLOAD, PCLOAD, IRLOAD, DRLOAD, RLOAD, ALOAD, ZLOAD : std_logic;
	--counting controls
	signal SPCNT, SPUD, PCCNT, PCCLR : std_logic;
	--mux selectors
	signal MARSEL, ASEL : std_logic_vector(1 downto 0);
	signal DRSEL, ALUSEL : std_logic;

begin
	
	
	
end architecture;