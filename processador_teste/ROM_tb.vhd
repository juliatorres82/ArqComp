library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_tb is
end entity;

architecture sim of rom_tb is
    signal clk      : std_logic := '0';
    signal endereco : unsigned(6 downto 0) := (others => '0');
    signal dado     : unsigned(15 downto 0);

    component ROM
        port (
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(15 downto 0)
        );
    end component;

begin

    uut: ROM
        port map (
            clk      => clk,
            endereco => endereco,
            dado     => dado
        );

   
    clock_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    
    stim_proc: process
    begin
        
        wait for 10 ns;
        endereco <= to_unsigned(0, 7); wait for 10 ns;
        endereco <= to_unsigned(1, 7); wait for 10 ns;
        endereco <= to_unsigned(2, 7); wait for 10 ns;
        endereco <= to_unsigned(4, 7); wait for 10 ns;
        endereco <= to_unsigned(6, 7); wait for 10 ns;
        endereco <= to_unsigned(8, 7); wait for 10 ns;
        wait;
    end process;

end architecture;
