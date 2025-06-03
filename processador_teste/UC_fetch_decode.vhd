library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UC_fetch_decode is
    port(

    );
end entity;

architecture a_arc of UC_fetch_decode is 

--declarando componentes:

component ula_banco_acu is
    port (
    clk          : in std_logic;
    rst          : in std_logic;
    dataWR_reg   : in unsigned (15 downto 0);
    wr_en_reg    : in std_logic;
    load_in_acc  : in std_logic; -- permite carregar dado direito no acc
    reg_r        : in unsigned(3 downto 0);
    opcode       : in unsigned (3 downto 0);
    borrow_in    : in std_logic;
    wr_en_acu    : in std_logic;
    data_out     : out unsigned (15 downto 0);
    eh_igual     : out std_logic
    );
end component;

component ROM_pc_regInst is
    port(
        clk:         in std_logic;
        rst:         in std_logic;
        wr_en_pc:    in std_logic;
        wr_en_addPC: in std_logic;
        dadoROM:     out unsigned(15 downto 0) -- dado atual da rom sai do registrador de instruções

    );
end component;

component UnidadeControle is
    port(
        clk        : in  std_logic;
        reset      : in  std_logic;
        instr      : in  unsigned(15 downto 0); -- intrução = é o dado out do REGISTRADOR DE INSTRUÇÕES.
        borrow_in  : in  std_logic;
        ula_opcode : out unsigned(3 downto 0); -- manda o opcode (4 MSB da instrução) p ula
        acc_write  : out std_logic; -- enable write no acumulador (a gnt nunca grava no registrador, smp no acumulador)
        en_romREAD : out std_logic; --habilita leitura da ROM
        reg_src    : out unsigned(3 downto 0); -- registrador source
        pc_write   : out std_logic; --habilita a escrita no pc
        jump_en    : out std_logicjump_en    : out std_logic
    );
end component;

--signals 
signal instrucao : unsigned(15 downto 0); -- sinal que conecta a saída do ROM_PC_INST até a entrada da uc
signal opcode    : unsigned (3 downto 0); -- passa o opcode da saída da uc para a entrada do ula_banco_acu
signal jumpEnable: std_logic;

begin
    --instanciando componentes:
    ulaBancoAcu: ula_banco_acu 
        port map(
            clk          =>  clk,
            rst          =>  rst,
            dataWR_reg   =>
            wr_en_reg    =>
            load_in_acc  =>
            reg_r        =>
            opcode       => opcode,
            borrow_in    =>
            wr_en_acu    =>
            data_out     =>
            eh_igual     =>
        );
    
    uc: UnidadeControle
        port map(
            clk         =>  clk,
            reset       =>  rst, 
            instr       => instrucao,
            borrow_in   =>
            ula_opcode  => opcode,
            acc_write   =>
            en_romREAD  =>
            reg_src     =>
            pc_write    =>
            jump_en     => jumpEnable
        );

    ROMPcRI: ROM_pc_regInst
        port map(
            clk          => clk,
            rst          => rst,
            wr_en_pc     =>
            wr_en_addPC  =>
            dadoROM      => instrucao
        );

