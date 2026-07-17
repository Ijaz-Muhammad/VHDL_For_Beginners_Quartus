library ieee;
use ieee.std_logic_1164.all;

entity FSM_edgeDetection is
port(
	clk, rst : in std_logic ;
	level 	: in std_logic ;
	tick		: out std_logic
);
end FSM_edgeDetection;

architecture behavioral of FSM_edgeDetection is
type edgeDect is (zero, one);
signal state_next, state_reg : edgeDect;
begin
-- state register 
process(clk, rst)
begin

	if(rst = '1') then
		state_reg <= zero;
	elsif(rising_edge(clk)) then
		state_reg <= state_next;
    end if;
end process;
-- state logic/ output logic
process(state_reg, level)
	begin
		state_next <= state_reg;
		tick <= '0';
		
		case state_reg is
		when zero => 
				if(level ='1') then 
					state_next <= one;
					tick <= '1';
				else
					state_next <= zero;
				end if;
		when one =>
				if(level /='1') then
					state_next <= zero;
				else
					state_next <= one;
				end if;
		end case;
	
	
	end process;

end behavioral;