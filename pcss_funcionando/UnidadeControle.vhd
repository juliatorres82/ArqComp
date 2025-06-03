library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


-- [ 4 bits ] [ 4 bits ] [ 8 bits ] 
--   opcode   reg source

entity UnidadeControle is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        instr      : in  unsigned(15 downto 0); -- intrução = é o dado out do REGISTRADOR DE INSTRUÇÕES.
        borrow_in  : in  std_logic;


        ula_opcode : out unsigned(3 downto 0); -- manda o opcode (4 MSB da instrução) p ula
        acc_write  : out std_logic; -- enable write no acumulador (a gnt nunca grava no registrador, smp no acumulador)
        --mem_write  : out std_logic; -- enable write na memória
        en_romREAD : out std_logic; --habilita leitura da ROM
        --en_ramWR   : out std_logic; --habilita escrita na ram
        --instReg_WR : out std_logic; --habilita a escrita no registrador de instrução
        reg_src    : out unsigned(3 downto 0); -- registrador source
        --reg_dst    : out unsigned(3 downto 0); -- registrador destino (mas smp eh o acc)
        pc_write   : out std_logic; --habilita a escrita no pc
        jump_en    : out std_logic
    );
end UnidadeControle;

architecture a_UnidadeControle of UnidadeControle is

    component maq_estados is
     port(
        clk, rst: in std_logic;
        estado: out unsigned(1 downto 0) -- 0 fetch; 1 decode/execute
    );
    end component;

    signal estado_atual : unsigned(1 downto 0) := "00";
    signal opcode : unsigned(3 downto 0) := "0000";
    
begin
    maq : maq_estados port map (clk => clk, rst => reset, estado => estado_atual);
    opcode <= instr (15 downto 12);
    jump_en <= '1' when opcode = "1000" else '0';

    --fase fetch:
    en_romREAD <= '1' when estado_atual = "00" else '0';
    pc_write <= '1' when estado_atual = "00" else '0';

    --fase execute/decode:
    acc_write <= '1' when estado_atual = "01" else '0';


end a_UnidadeControle;