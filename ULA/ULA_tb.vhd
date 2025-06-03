-- ULA_tb.vhd
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA_tb is
end entity;

architecture sim of ULA_tb is

    component ULA is
        port(
            acumulador_in  : in unsigned(15 downto 0);
            B              : in unsigned(15 downto 0);
            opcode         : in unsigned(3 downto 0);
            borrow_in      : in std_logic;
            acumulador_out : out unsigned(15 downto 0);
            outULA         : out unsigned(15 downto 0);
            eh_igual       : out std_logic
        );
    end component;

    -- Sinais de estímulo e resposta
    signal acumulador_in  : unsigned(15 downto 0) := (others => '0');
    signal B              : unsigned(15 downto 0) := (others => '0');
    signal opcode         : unsigned(3 downto 0) := (others => '0');
    signal borrow_in      : std_logic := '0';
    signal acumulador_out : unsigned(15 downto 0);
    signal outULA         : unsigned(15 downto 0);
    signal eh_igual       : std_logic;

begin

    -- Instância da ULA
    uut: ULA
        port map (
            acumulador_in  => acumulador_in,
            B              => B,
            opcode         => opcode,
            borrow_in      => borrow_in,
            acumulador_out => acumulador_out,
            outULA         => outULA,
            eh_igual       => eh_igual
        );

    -- Processo de estímulo
    process
    begin
        -- Teste 1: Soma 10 + 5
        acumulador_in <= to_unsigned(10, 16);
        B <= to_unsigned(5, 16);
        opcode <= "1111"; -- soma
        wait for 10 ns;

        -- Teste 2: Subtração 20 - 5
        acumulador_in <= to_unsigned(20, 16);
        B <= to_unsigned(5, 16);
        opcode <= "0000"; -- sub
        wait for 10 ns;

        -- Teste 3: SUBB 20 - 5 - 1
        acumulador_in <= to_unsigned(20, 16);
        B <= to_unsigned(5, 16);
        borrow_in <= '1';
        opcode <= "1001"; -- subb
        wait for 10 ns;
        borrow_in <= '0';

        -- Teste 4: CMPI (iguais)
        acumulador_in <= to_unsigned(33, 16);
        B <= to_unsigned(33, 16);
        opcode <= "1010";
        wait for 10 ns;

        -- Teste 5: CMPI (diferentes)
        acumulador_in <= to_unsigned(33, 16);
        B <= to_unsigned(22, 16);
        opcode <= "1010";
        wait for 10 ns;

        -- Teste 6: CLZ
        acumulador_in <= "0000000000001000"; -- 12 zeros à esquerda
        opcode <= "1011"; -- CLZ
        wait for 10 ns;

        wait;
    end process;

end architecture;
