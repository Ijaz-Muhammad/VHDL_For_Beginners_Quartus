library ieee;
use ieee.std_logic_1164.all;

entity FSM_example1 is
port(
		clk, rst	: in std_logic;
		level		: in std_logic;
		tick		: out std_logic
);
end entity;

architecture myfsm of FSM_example1 is 

type edge_detection is (zero, edge , one);
signal state_next, state_reg : edge_detection;

begin
	-- state register 
	process(clk, rst)
	begin
		if(rst ='1') then
			state_reg <= zero;
		elsif(rising_edge (clk)) then
			state_reg <= state_next;
		end if;
	
	end process;
-- next state / output logic  --detection based on moore machine 
	process(state_next, level)
	begin
		state_next <= state_reg;
		tick <= '0';
		
		case state_reg is
			when zero =>
					if level /='1' then
						state_next <= zero;
					else
						state_next <= edge;
					end if;
			when edge => 
					tick <= '1';
					state_next <= one;
			when one =>
					if(level ='1') then
						state_next <= one;
					else
						state_next <= zero;
					end if;
		end case;
	
	
	end process;

end myfsm;