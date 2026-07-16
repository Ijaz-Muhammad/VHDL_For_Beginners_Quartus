library ieee;
use ieee.std_logic_1164.all;

entity DFF_sync_tb is
end DFF_sync_tb;

architecture behavioral of DFF_sync_tb is 

component DFF_sync is
port(
	clk, rst : in std_logic ;	-- clk and reset initialized and direction are input
	d 			: in std_logic ;  -- data input for DFF
	q			: out std_logic   -- data output for DFF
	);
end component;

signal clock  : std_logic := '0'; -- clock initialized with 0;
signal reset  : std_logic := '1'; -- reset initialized with 1;
signal d_in   : std_logic := '0'; -- clock initialized with 0;
signal q_out  : std_logic;

begin 
-- module intentiation for mapping
UUT1: DFF_sync port map(
									clk => clock, 
									rst => reset,
									d	 => d_in ,
									q   => q_out 
							 );

-- this process is initiated for only clock generation							
clock_process: process(clock)
begin
clock <= not clock after 5ns;  -- continous clock generation
end process;

-- this process is initiated for inputs simulous
stim_process: process
begin
	reset <= '1';  
	d_in	<= '1';
	
	wait for 100ns;
	
	reset <= '0';
	
	wait for 20ns;
	
	d_in  <= '0';
	
	wait for 50ns;
	
	d_in  <= '1';
	
	wait;


end process;

end behavioral;

