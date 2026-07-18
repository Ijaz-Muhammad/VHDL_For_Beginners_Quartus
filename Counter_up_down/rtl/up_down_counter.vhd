library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Counter_upDown is
port(
	clk , rst 	: in std_logic;
	up, down 	: in std_logic;
	Cntr_out		: out std_logic_vector(15 downto 0)
);

end Counter_updown;

architecture behavioral of Counter_UPDOWN	is
signal temp : std_logic_vector(15 downto 0):=x"0000";

begin
	process(clk,rst,up,down)
	begin
		if (rst ='1') then
			temp <= x"0000";
		elsif(rising_edge(clk)) then
			if (up ='1') then
				temp <= temp + 1;
			elsif (down ='1') then
				temp <= temp - 1;
			else
				temp <= temp;
			end if;
		end if;
	end process;
	cntr_out <= temp;

end behavioral;