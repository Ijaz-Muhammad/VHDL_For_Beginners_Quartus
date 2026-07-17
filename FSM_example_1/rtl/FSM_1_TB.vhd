library ieee;
use ieee.std_logic_1164.all;

entity FSM_1_TB is
end entity;

architecture tb of FSM_1_TB is

component FSM_example1 is
port(
    clk   : in std_logic;
    rst   : in std_logic;
    level : in std_logic;
    tick  : out std_logic
);
end component;

signal clk_1   : std_logic := '0';
signal rst_1   : std_logic := '1';
signal level_1 : std_logic := '0';
signal tick_1  : std_logic;

begin

UUT : FSM_example1
port map(
    clk   => clk_1,
    rst   => rst_1,
    level => level_1,
    tick  => tick_1
);

clock_gen : process
begin
    while true loop
        clk_1 <= '0';
        wait for 5 ns;
        clk_1 <= '1';
        wait for 5 ns;
    end loop;
end process;

logic_process : process
begin
    rst_1   <= '1';
    level_1 <= '0';

    wait for 100 ns;

    rst_1 <= '0';

    wait for 100 ns;

    level_1 <= '1';

    wait for 100 ns;

    level_1 <= '0';

    wait for 100 ns;

    wait;
end process;

end architecture;