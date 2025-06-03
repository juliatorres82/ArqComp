library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity topLevel is
end entity;

architecture a_topLevel of topLevel is
    component ROM is
    port(
        clk      : in std_logic;
        endereco : in unsigned(6 downto 0); --128 enderecos
        dado     : out unsigned(15 downto 0) -- largura de 16 bits
    );
    end component;

    component maq_estados is 
    port(
        clk, rst: in std_logic;
        estado: out unsigned(1 downto 0)
    );
    end component;
