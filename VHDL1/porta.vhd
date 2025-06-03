library ieee;
use ieee.std_logic_1164.all;

-- entity é o bloco q construiremos
-- nome da entity e do arquivo preferencialmente =
entity porta is
    port (
        in_a : in std_logic; -- std_logic : tamanho = 1 bit
        in_b : in std_logic;
        a_e_b: out std_logic
    );
end entity;

-- arquitetura é a implementação do bloco
architecture a_porta of porta is
begin
    a_e_b <= in_a and in_b;
end architecture;
-- entre begin e end há a circuitaria