library ieee;
use ieee.std_logic_1164.all;
library lpm;
use lpm.lpm_components.all;

entity reg_file is
	port(
		clk : in std_logic;
		clk2 : in std_logic;
		uOps : in std_logic_vector(29 downto 9); --from useq
		M_q : in std_logic_vector(7 downto 0); --from ram
		opcode : out std_logic_vector(3 downto 0);
		A_q_out : out std_logic_vector(7 downto 0);
		M_data : out std_logic_vector(7 downto 0);
		M_addr : out std_logic_vector(7 downto 0); --to ram
		M_write : out std_logic --to ram
	);
end entity;

architecture structural of reg_file is
	component exp7_alu is
		port(
			a, b: in std_logic_vector(7 downto 0);
			op: in std_logic_vector(0 downto 0);   
			result: out std_logic_vector(7 downto 0)
		);
	end component;
	--register outputs
	signal SP_q, PC_q, IR_q, DR_q, R_q, A_q: std_logic_vector(7 downto 0);
	signal Z_q : std_logic_vector(0 downto 0);
	--register loads
	signal MARLOAD, SPLOAD, PCLOAD, IRLOAD, DRLOAD, RLOAD, ALOAD, ZLOAD : std_logic;
	--counting controls
	signal SPCNT, SPUD, PCCNT, PCCLR : std_logic;
	--mux selectors
	signal MARSEL, ASEL : std_logic_vector(1 downto 0);
	signal DRSEL, ALUSEL : std_logic_vector(0 downto 0);
	--intermediate signals
	signal MAR_mux_data : std_logic_2D(3 downto 0, 7 downto 0);
	signal MAR_mux_out : std_logic_vector(7 downto 0);
	signal DR_mux_data : std_logic_2D(1 downto 0, 7 downto 0);
	signal DR_mux_out : std_logic_vector(7 downto 0);
	signal ALU_out : std_logic_vector(7 downto 0);
	signal A_mux_data : std_logic_2D(3 downto 0, 7 downto 0);
	signal A_mux_out : std_logic_vector(7 downto 0);
	signal Z_mux_out : std_logic_vector(0 downto 0);
	signal V, VNOT : std_logic;
begin
  
  UOPS_TO_CONTROL_SIGNALS:
    M_write 	<= uOps(29);
    MARLOAD 	<= (uOps(28) OR uOps(27) OR uOps(26));
    MARSEL(0) 	<= uOps(28);
    MARSEL(1) 	<= uOPs(27) ;
    PCCNT 		<= uOPs(25) ;
    PCLOAD 		<= (uOPs(10) OR ( uOps(9) AND Z_q(0) )) ;
    PCCLR 		<= uOPs(24) ;
    DRLOAD 		<= (uOPs(23) OR uOPs(22)) ;
    DRSEL(0) 	<= uOPs(22) ;
    ALOAD 		<= (uOps(21) OR uOps(20) OR uOps(21) OR uOps(18)) ;
    ASEL(0) 	<= uOps(21) ;
    ASEL(1) 	<= uOps(18) ;
    ALUSEL(0) 	<= uOps(19) ;
    ZLOAD 		<= (uOps(17) OR uOps(16)) ;
    SPLOAD 		<= uOps(15) ;
    SPCNT 		<= (uOps(14) OR uOps(13)) ;
    SPUD 		<= uOps(13) ;
    RLOAD 		<= uOps(12) ;
    IRLOAD 		<= uOps(11) ;

	GEN_MUX_SIGNALS: for i in 0 to 7 generate
		MAR_mux_data(0, i) <= SP_q(i);
		MAR_mux_data(1, i) <= PC_q(i);
		MAR_mux_data(2, i) <= DR_q(i);
		MAR_mux_data(3, i) <= '0';
		DR_mux_data(0, i) <= M_q(i);
		DR_mux_data(1, i) <= A_q(i);
		A_mux_data(0, i) <= ALU_out(i);
		A_mux_data(1, i) <= DR_q(i);
		A_mux_data(2, i) <= R_q(i);
		A_mux_data(3, i) <= '0';
	end generate;
	
	MAR_MUX: lpm_mux
		generic map(lpm_width=>8, lpm_size=>4, lpm_widths=>2)
		port map(data=>MAR_mux_data, sel=>MARSEL, result=>MAR_mux_out);
		
	MAR_REG: lpm_ff
		generic map(lpm_width=>8)
		port map(clock=>clk, enable=> MARLOAD, data=>MAR_mux_out, q=>M_addr);
	
	SP_COUNTER: lpm_counter
		generic map(lpm_width=>8)
		port map(clock=>clk2, data=>DR_q, sload=>SPLOAD, cnt_en=>SPCNT, updown=>SPUD, q=>SP_q);
	
	PC_COUNTER: lpm_counter
		generic map(lpm_width=>8)
		port map(clock=>clk2, data=>DR_q, sload=>PCLOAD, cnt_en=>PCCNT, sclr=>PCCLR, q=>PC_q);
	
	IR_REG: lpm_ff
		generic map(lpm_width=>8)
		port map(clock=>clk, enable=>IRLOAD, data=>DR_q, q=>IR_q);
	opcode <= IR_q(7 downto 4);
	
	DR_MUX: lpm_mux
		generic map(lpm_width=>8, lpm_size=>2, lpm_widths=>1)
		port map(data=>DR_mux_data, sel => DRSEL, result => DR_mux_out);
	
	DR_REG: lpm_ff
		generic map(lpm_width=>8)
		port map(clock=>clk, enable=>DRLOAD, data=>DR_mux_out, q=>DR_q);
	M_data <= DR_q;
	R_REG: lpm_ff
		generic map(lpm_width=>8)
		port map(clock=>clk, enable=>RLOAD, data=>A_q, q=>R_q);
	
	ALU: exp7_alu
		port map(a=>A_q, b=>R_q, op=>ALUSEL, result=>ALU_out);
	
	A_MUX: lpm_mux
		generic map(lpm_width=>8, lpm_size=>4, lpm_widths=>2)
		port map(data=>A_mux_data, sel=>ASEL, result=>A_mux_out);
	
	A_REG: lpm_ff
		generic map(lpm_width=>8)
		port map(clock=>clk2, enable=>ALOAD, data=>A_mux_out, q=>A_q);
	A_q_out <= A_q;
	
	Z_ORGATE:
		V <= A_q(7) OR A_q(6) OR A_q(5) OR A_q(4)
		OR A_q(3)OR A_q(2) OR A_q(1) OR A_q(0);
		VNOT <= NOT V;
	
	Z_MUX:
		with IR_q(0) select Z_mux_out(0) <=
		VNOT when '0',
		V when '1',
		'0' when others;
		
	Z_REG: lpm_ff
		generic map(lpm_width=>1)
		port map(clock=>clk, enable=>ZLOAD, data=>Z_mux_out, q=>Z_q);
	
end architecture;
