library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ROM_pc_regInst is
    port(
        clk:         in std_logic;
        rst:         in std_logic;
        wr_en_pc:    in std_logic;
        wr_en_addPC: in std_logic;
        dadoROM:     out unsigned(15 downto 0) -- dado atual da rom sai do registrador de instruções

    );
end entity;

architecture a_rom_pc of ROM_pc_regInst is

    component ROM is
        port(
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(15 downto 0)
        );
    end component;

    component PC is 
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(6 downto 0); 
            data_out : out unsigned(6 downto 0)
        );
    end component;

    component addPC is 
        port(
            entrada : in unsigned(6 downto 0);
            wr_en   : in std_logic;
            saida   : out unsigned(6 downto 0)
        );
    end component;

    component RegInstrucao is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0); 
            data_out : out unsigned(15 downto 0)
        );
    end component;
    
    signal mux_pc      : unsigned(6 downto 0); -- seleciona se entra no pc tudo 0 (primeira op) ou o out do addPC
    signal data_out_pc : unsigned(6 downto 0);  -- conecta saída do pc à entrada do addPC E à entrada da ROM
    signal out_addPC   : unsigned(6 downto 0); -- saída do addPC (p conectarmos ao mux)
    signal dadoROM_int : unsigned(15 downto 0); -- conecta saída da rom à entrada do registrador de instruções
    signal outRegInst  : unsigned(15 downto 0); -- saída final do regInst = dataOut do conjunto
    signal flagInicio  : std_logic := '1'; -- flag para poder iniciar  PC em 0. Dps do primeiro clock, a entrada dele recebe smp outaddPC

begin

    -- começa em 0 e volta pra 0 sempre q reseta. cc, sempre em 1
    flagInicio <= '1' when rst = '1' else '0';
    --mux: entrada do PC é zero na primeira vez, dps o out de addPC
    mux_pc <= (others => '0') when flagInicio = '1' else out_addPC;


    uROM: ROM 
        port map(
            clk      => clk,
            endereco => data_out_pc,
            dado     => dadoROM_int
        );

    uPC: PC
        port map (
            clk      => clk,
            rst      => rst,
            wr_en    => wr_en_pc,
            data_in  => mux_pc,
            data_out => data_out_pc
        );

    uADDPC: addPC
        port map(
            entrada => data_out_pc,
            wr_en   => wr_en_addPC,
            saida   => out_addPC
        );

    uuRI: RegInstrucao
        port map(
            clk      => clk,
            rst      => rst, 
            wr_en    => wr_en_pc,
            data_in  => dadoROM_int,
            data_out => outRegInst
        );

    dadoROM <= outRegInst;

end architecture;
