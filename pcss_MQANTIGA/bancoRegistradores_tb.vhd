library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity bancoRegistradores_tb is 
end entity;

architecture bancoRegistradores_tb of bancoRegistradores_tb is
    component bancoRegistradores is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            reg_r    : in unsigned(3 downto 0); 
            data_wr  : in unsigned(15 downto 0); 
            data_out : out unsigned(15 downto 0)
        );
    end component;

    constant period_time : time := 100 ns; -- periodo do clock
    signal finished      : std_logic := '0';
    signal clk, rst      : std_logic := '0';
    signal wr_en         : std_logic := '0';
    signal reg_r         : unsigned(3 downto 0) := "0000";
    signal data_wr       : unsigned(15 downto 0) := (others => '0');
    signal data_out      : unsigned(15 downto 0);
begin 
    uut: bancoRegistradores
        port map (
            clk      => clk,
            rst      => rst,
            wr_en    => wr_en,
            reg_r    => reg_r,
            data_wr  => data_wr,
            data_out => data_out
        );

    clk_process: process
    begin
        while finished = '0' loop
            clk <= '0';
            wait for period_time / 2;
            clk <= '1';
            wait for period_time / 2;
        end loop;
        wait;
    end process;

    reset_global: process 
    begin 
        rst <= '1';
        wait for period_time * 2;
        rst <= '0';
        wait;
    end process;

    -- substituição de todos os testerX por um processo sequencial
    testes: process
    begin
        wait until rst = '0';  -- aguarda fim do reset
        wait until rising_edge(clk); -- primeira borda útil do clock

        -- Teste 1
        reg_r   <= "0000";
        data_wr <= "0000000011111111";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 2
        reg_r   <= "0001";
        data_wr <= "0000000010000000";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 3
        reg_r   <= "0010";
        data_wr <= "0000000000000010";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 4
        reg_r   <= "0011";
        data_wr <= "0000000000000011";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 5
        reg_r   <= "0100";
        data_wr <= "0000000000000100";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 6
        reg_r   <= "0101";
        data_wr <= "0000000011110101";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 7
        reg_r   <= "0110";
        data_wr <= "0000000011010101";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 8
        reg_r   <= "0111";
        data_wr <= "0000000000000111";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 9
        reg_r   <= "1000";
        data_wr <= "0000000011101000";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste 10
        reg_r   <= "1001";
        data_wr <= "0000000011110001";
        wr_en   <= '1';
        wait until rising_edge(clk);
        wr_en   <= '0';
        wait until rising_edge(clk);

        -- Teste de duas escritas seguidas
        reg_r   <= "0010";
        wr_en   <= '1';
        data_wr <= "1110000011110000";
        wait until rising_edge(clk);
        data_wr <= "0000000011111111";
        wait until rising_edge(clk);
        wr_en   <= '0';

        wait;
    end process;

    finish_sim: process
    begin
        wait for 2000 ns;
        finished <= '1';
        wait;
    end process;

end architecture bancoRegistradores_tb;
