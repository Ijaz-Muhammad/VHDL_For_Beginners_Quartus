library ieee;
use ieee.std_logic_1164.all;

-- port initialization for synchornuous DFF
entity DFF_sync is 
port(
	clk, rst : in std_logic ;	-- clk and reset initialized and direction are input
	d 			: in std_logic ;  -- data input for DFF
	q			: out std_logic   -- data output for DFF
	);
end DFF_sync;

-- architecture flow of DFF
architecture behavioral of DFF_sync is 
begin
	process(clk) -- syncronous DFF the operation only dependent to its clk 
		begin
			-- 
			if(rising_edge(clk)) then 
				if(rst = '1') then  
					q <= '0'; -- if it is in reset mode the output will be 0
				else
					q <= d; -- if it is not in reset mode the output will be d
				end if;
			
			end if;

		end process;
end behavioral;