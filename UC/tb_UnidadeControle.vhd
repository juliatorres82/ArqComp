library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity tb_UnidadeControle is
end entity;

architecture aUC of tb_UnidadeControle is
    component UnidadeControle is
    port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        instr      : in  std_logic_vector(15 downto 0);
        borrow_in  : in  std_logic;

        ula_opcode : out std_logic_vector(3 downto 0);
        acc_write  : out std_logic;
        mem_write  : out std_logic;
        reg_src    : out std_logic_vector(3 downto 0);
        reg_dst    : out std_logic_vector(3 downto 0);
        pc_write   : out std_logic
    );
    end component;

    constant period_time: time := 100 ns; --periodo de um clock
    signal clk, reset, borrow_in, acc_write, mem_write, pc_write: std_logic := '0';
    signal instr: std_logic_vector(15 downto 0) := (others => '0');
    signal ula_opcode, reg_src, reg_dst: std_logic_vector(3 downto 0) := (others => '0');

begin
    uut: UnidadeControle 
        port map(
            clk => clk,
            reset => reset,
            instr => instr,
            borrow_in => borrow_in,
            ula_opcode => ula_opcode,
            acc_write => acc_write,
            mem_write => mem_write,
            reg_src => reg_src,
            reg_dst => reg_dst,
            pc_write => pc_write
        );

    reset_global: process 
    begin 
        reset <= '1';
        wait for period_time*2; 
        reset <= '0';
        wait;
    end process;

    stimulus_process: process
    begin
        borrow_in <= '0';
        wait until reset = '0'; 
        
        -- bota instrucao generica
        instr <= "0001000100010001"; -- Opcode 0001
        wait for period_time*5;
        wait;
    end process;
end architecture;
