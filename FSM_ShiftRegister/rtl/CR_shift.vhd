library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CR_shift is
port(
    clk          : in  std_logic;
    rst          : in  std_logic;
    load_data    : in  std_logic_vector(5 downto 0);
    shift_count  : in  std_logic_vector(2 downto 0);
    new_data     : in  std_logic;
    shifted_data : out std_logic_vector(5 downto 0)
);
end CR_shift;

architecture beh of CR_shift is

    type FSM_circular_shift is (LOAD, SHIFT, NEWDATA);

    signal state_reg, state_next : FSM_circular_shift;

    signal temp_reg, temp_next : std_logic_vector(5 downto 0);

    signal counter_reg : integer range 0 to 6 := 0;
    signal counter_next : integer range 0 to 6 := 0;

begin

--------------------------------------------------------------------------
-- Register Process
--------------------------------------------------------------------------
reg_process : process(clk, rst)
begin
    if rst = '1' then
        state_reg   <= LOAD;
        temp_reg    <= (others => '0');
        counter_reg <= 0;

    elsif rising_edge(clk) then
        state_reg   <= state_next;
        temp_reg    <= temp_next;
        counter_reg <= counter_next;
    end if;
end process;

--------------------------------------------------------------------------
-- Next-State / Logic Process
--------------------------------------------------------------------------
logic_process : process(state_reg, temp_reg, counter_reg,
                        load_data, shift_count, new_data)
begin

    -- Default assignments
    state_next   <= state_reg;
    temp_next    <= temp_reg;
    counter_next <= counter_reg;

    case state_reg is

        --------------------------------------------------------------
        when LOAD =>
            temp_next    <= load_data;
            counter_next <= 0;
            state_next   <= SHIFT;

        --------------------------------------------------------------
        when SHIFT =>

            if counter_reg < to_integer(unsigned(shift_count)) then
                counter_next <= counter_reg + 1;
                temp_next    <= temp_reg(0) & temp_reg(5 downto 1);
                state_next   <= SHIFT;
            else
                counter_next <= 0;
                state_next   <= NEWDATA;
            end if;

        --------------------------------------------------------------
        when NEWDATA =>

            if new_data = '1' then
                state_next <= LOAD;
            else
                state_next <= NEWDATA;
            end if;

    end case;

end process;

--------------------------------------------------------------------------
-- Output
--------------------------------------------------------------------------
shifted_data <= temp_reg;

end beh;