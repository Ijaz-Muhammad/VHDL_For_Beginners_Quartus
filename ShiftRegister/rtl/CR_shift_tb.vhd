library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CR_shift_tb is
end CR_shift_tb;

architecture beh of CR_shift_tb is

component CR_shift
port(
    clk          : in std_logic;
    rst          : in std_logic;
    load_data    : in std_logic_vector(5 downto 0);
    shift_count  : in std_logic_vector(2 downto 0);
    new_data     : in std_logic;
    shifted_data : out std_logic_vector(5 downto 0)
);
end component;

signal clk          : std_logic := '0';
signal rst          : std_logic := '1';
signal load_data    : std_logic_vector(5 downto 0) := "111000";
signal shift_count  : std_logic_vector(2 downto 0) := "011";
signal new_data     : std_logic := '0';
signal shifted_data : std_logic_vector(5 downto 0);

begin

uut : CR_shift
port map(
    clk          => clk,
    rst          => rst,
    load_data    => load_data,
    shift_count  => shift_count,
    new_data     => new_data,
    shifted_data => shifted_data
);

------------------------------------------------------------------
-- Clock Generation
------------------------------------------------------------------
clock_gen : process
begin
    while true loop
        clk <= '0';
        wait for 5 ns;
        clk <= '1';
        wait for 5 ns;
    end loop;
end process;

------------------------------------------------------------------
-- Stimulus
------------------------------------------------------------------
stimulus : process
begin

    -- Hold reset
    wait for 100 ns;
    rst <= '0';

    -- Wait for first shift operation to complete
    wait for 100 ns;

    -- Load new data
    load_data <= "101010";

    -- Pulse new_data
    new_data <= '1';
    wait for 10 ns;
    new_data <= '0';

    -- Wait to observe second operation
    wait for 200 ns;

    wait;

end process;

end beh;