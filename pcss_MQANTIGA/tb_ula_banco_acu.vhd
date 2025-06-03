library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ula_banco_acu is
end entity;

architecture aTBUBA of tb_ula_banco_acu is

    component ula_banco_acu 
        port(
            clk          : in std_logic;
            rst          : in std_logic;
            dataWR_reg   : in unsigned (15 downto 0);
            wr_en_reg    : in std_logic;
            reg_r        : in unsigned(3 downto 0);
            opcode       : in unsigned (3 downto 0);
            borrow_in    : in std_logic;
            wr_en_acu    : in std_logic;
            data_out     : out unsigned (15 downto 0);
            eh_igual     : out std_logic
        );
    end component;

    signal clk          : std_logic := '0';
    signal rst          : std_logic := '0';
    signal dataWR_reg   : unsigned (15 downto 0) := (others => '0');
    signal wr_en_reg    : std_logic := '0';
    signal reg_r        : unsigned(3 downto 0) := (others => '0');
    signal opcode       : unsigned (3 downto 0) := (others => '0');
    signal borrow_in    : std_logic := '0';
    signal wr_en_acu    : std_logic := '0';
    signal data_out     : unsigned (15 downto 0);
    signal eh_igual     : std_logic;

begin 

    DUT: ula_banco_acu
        port map(
            clk         => clk,
            rst         => rst,
            dataWR_reg  => dataWR_reg,
            wr_en_reg   => wr_en_reg,
            reg_r       => reg_r,
            opcode      => opcode,
            borrow_in   => borrow_in,
            wr_en_acu   => wr_en_acu,
            data_out    => data_out,
            eh_igual    => eh_igual
        );

    reset_process : process 
    begin
        rst <= '1';
        wait for 200 ns;
        rst <= '0';
        wait;
    end process;

    clk_process : process
    begin
        loop
            clk <= '0';
            wait for 200 ns;
            clk <= '1';
            wait for 200 ns;
        end loop; 
    end process;

    processinho : process 
    begin
        -- PASSO 1: grava 0x000A no registrador 3
        reg_r       <= "0011";
        dataWR_reg  <= x"000A";
        wr_en_reg   <= '1';
        wait until rising_edge(clk);
        wr_en_reg   <= '0';
        wait for 100 ns;

        -- PASSO 2: opera ULA com esse valor (B=0x000A), acumulador = 0, opcode soma
        opcode      <= "1111";  -- supondo que 1111 seja soma
        wr_en_acu   <= '1';     -- escreve no acumulador
        wait until rising_edge(clk);
        wr_en_acu   <= '0';
        wait for 100 ns;

        -- PASSO 3: grava 0x0001 no mesmo registrador 3 (novo B)
        reg_r       <= "0011";
        dataWR_reg  <= x"0001";
        wr_en_reg   <= '1';
        wait until rising_edge(clk);
        wr_en_reg   <= '0';
        wait for 100 ns;

        -- PASSO 4: nova operação: A (0x000A) + B (0x0001) → acumulador deve receber 0x000B
        wr_en_acu   <= '1';
        wait until rising_edge(clk);
        wr_en_acu   <= '0';
        wait for 100 ns;

        -- VERIFICA RESULTADO
        assert data_out = x"000B"
            report "Erro: esperado 0x000B, recebido " & integer'image(to_integer(data_out))
            severity error;

        assert false report "Fim da simulação" severity note;
        wait;
    end process;

end architecture;
