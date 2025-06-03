library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom_pc_tb is
end entity;

architecture sim of rom_pc_tb is
    -- Componente a ser testado
    component ROM_pc_regInst is
        port(
            clk:         in std_logic;
            rst:         in std_logic;
            wr_en_pc:    in std_logic;
            wr_en_addPC: in std_logic;
            dadoROM:     out unsigned(15 downto 0)
        );
    end component;

    -- Sinais de teste
    signal clk          : std_logic := '0';
    signal rst          : std_logic := '1';
    signal wr_en_pc     : std_logic := '0';
    signal wr_en_addPC  : std_logic := '0';
    signal dadoROM      : unsigned(15 downto 0);
    constant clk_period : time := 10 ns;

begin
    -- Instancia o componente
    uut: ROM_pc_regInst
        port map(
            clk         => clk,
            rst         => rst,
            wr_en_pc    => wr_en_pc,
            wr_en_addPC => wr_en_addPC,
            dadoROM     => dadoROM
        );

    -- Gera o clock
    clk_process: process
    begin
        while now < 200 ns loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait;
    end process;

    -- Estímulos
    stim_proc: process
    begin
        -- Reset inicial
        rst <= '1';
        wait for clk_period;
        rst <= '0';

        -- Inicialmente, PC = 0, ROM lê endereço 0
        wr_en_pc <= '1';
        wr_en_addPC <= '1';
        wait for clk_period;

        -- Incrementa PC -> 1
        wr_en_addPC <= '1';
        wr_en_pc <= '1';
        wait for clk_period;

        -- Mantém valores para leitura estável
        wr_en_pc <= '0';
        wr_en_addPC <= '0';
        wait for clk_period;

        -- Incrementa PC -> 2
        wr_en_addPC <= '1';
        wr_en_pc <= '1';
        wait for clk_period;

        -- Leitura estável
        wr_en_pc <= '0';
        wr_en_addPC <= '0';
        wait for clk_period;

        -- Incrementa PC -> 3
        wr_en_addPC <= '1';
        wr_en_pc <= '1';
        wait for clk_period;

        -- Fim da simulação
        wait;
    end process;

end architecture;
