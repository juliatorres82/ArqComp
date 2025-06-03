library ieee;
use ieee.std_logic_1164.all;

--testbench - arquivo de teste

entity decoder_tb is
end entity;

architecture a_decoder of decoder_tb is
    component decoder
    port (
        in_a : in std_logic;
        in_b : in std_logic;
        p0 : out std_logic;
        p1 : out std_logic;
        p2 : out std_logic;
        p3 : out std_logic
        );
    end component;

    signal inA, inB, out0, out1, out2, out3: std_logic;
    begin
        uut: decoder port map ( 
            in_a => inA,
            in_b => inB,
            p0 => out0,
            p1 => out1,
            p2 => out2,
            p3 => out3
        );
    process
        begin
            inA <= '0';
            inB <= '0';
            wait for 50 ns;

            inA <= '0';
            inB <= '1';
            wait for 50 ns;

            inA <= '1';
            inB <= '0';
            wait for 50 ns;

            inA <= '1';
            inB <= '1';
            wait for 50 ns;
            wait;
        end process;
    end architecture;