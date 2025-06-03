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
        0 => "0000000000000010",
        1 => "1000000000000000",
        2 => "0000000000000000",
        3 => "0000000000000000",
        4 => "1000000000000000",
        5 => "0000000000000010",
        6 => "1111000000000011",
        7 => "0000000000000010",
        8 => "0000000000000010",
        9 => "0000000000000000",
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