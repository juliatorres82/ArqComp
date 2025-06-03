library ieee;
use ieee.std_logic_1164.all;

entity decoder is
    port (
    in_a : in std_logic;
    in_b : in std_logic;
    p0 : out std_logic;
    p1 : out std_logic;
    p2 : out std_logic;
    p3 : out std_logic
    );
end entity;

architecture a_decoder of decoder is
    begin 
        p0 <= not in_a and not in_b;
        p1 <= not in_a and in_b;
        p2 <= in_a and not in_b;
        p3 <= in_a and in_b;
    end architecture;

