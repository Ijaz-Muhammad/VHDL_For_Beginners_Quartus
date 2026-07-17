library ieee;
use ieee.std_logic_1164.all;

entity FSM_tb is
end FSM_tb;

architecture beha of FSM_tb is
component FSM_edgeDetection is
port(
	clk, rst : in std_logic ;
	level 	: in std_logic ;
	tick		: out std_logic
);
end component;
signal clk_1 : std_logic:='0';
signal rst_1 : std_logic:='1';
signal level_1: std_logic:='0';
signal tick_1: std_logic;

begin
uut: FSM_edgeDetection port map(
										clk => clk_1,
										rst => rst_1,
										level => level_1,
										tick 	=> tick_1
										);
process(clk_1)
begin
clk_1 <= not clk_1 after 5ns;
end process;

process
begin
rst_1 <= '1';
level_1 <= '0';
wait for 100ns;

rst_1 <='0';
wait for 20ns;
level_1 <='1';

wait for 100ns;
level_1 <='0';

wait;
end process;

end beha;