library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM is
    port(
        clk      : in std_logic;
        endereco : in unsigned(6 downto 0); --128 enderecos
        dado     : out unsigned(15 downto 0) -- largura de 16 bits
    );
end entity;

architecture a_rom of ROM is
    type mem is array (0 to 127) of unsigned (15 downto 0);
    constant conteudo_rom : mem := (
        0 => "1000000000000001",
        1 => "1000000000000010",
        2 => "1000000000000011",
        3 => "1000000000000100",
        4 => "1000000000000101",
        5 => "1000000000000110",
        6 => "1000000000000111",
        7 => "1000000000001000",
        8 => "1000000000001001",
        9 => "1000000000001010",
        others => (others => '0')
    );
begin
    process(clk)
    begin
        if (rising_edge(clk)) then
            -- saída "dado" envia o conteúdo do endereço
            dado <= conteudo_rom(to_integer(endereco));
        end if;
    end process;
end architecture;