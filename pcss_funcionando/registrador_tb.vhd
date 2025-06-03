library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity registrador_tb is
end entity;

architecture registrador_tb of registrador_tb is
    component registrador
        port (
            clk     : in std_logic;
            rst     : in std_logic;
            wr_en   : in std_logic;
            data_in : in unsigned(15 downto 0);
            data_out: out unsigned(15 downto 0)
        );
    end component;
    constant period_time: time := 100 ns; --periodo de um clock
    signal   finished   : std_logic := '0';
    signal   clk, rst : std_logic := '0';
    signal   wr_en      : std_logic := '0';
    signal   data_in   : unsigned(15 downto 0) := "0000000000000000";
    signal   data_out  : unsigned(15 downto 0) := "0000000000000000";


    begin
        uut: registrador
            port map (
                clk     => clk,
                rst     => rst,
                wr_en   => wr_en,
                data_in => data_in,
                data_out=> data_out
            );

        reset_global: process 
        begin 
            rst <= '1';
            wait for period_time*2; 
            rst <= '0';
            wait;
        end process;

        sim_time_proc: process -- esse aq define o tempo total de TODA a simulação
        begin
            wait for 10 us; 
            finished <= '1';
            wait;
        end process;

        clk_proc: process
        begin
            while finished /= '1' loop -- gera clock até q sim_time termine
            clk <= '0';
            wait for period_time/2;
            clk <= '1';
            wait for period_time/2;
            end loop;
            wait;
        end process;

      
        t1: process
        begin 
            wait for 200 ns;
            wr_en <= '1';
            data_in <= "1111111111111111";
            wait for 200 ns;
            wait;
        end process;
        
        t2: process
        begin 
            wait for 400 ns;
            wr_en <= '1';
            data_in <= "0000010100100000";
            wait for 200 ns;
            wait;
        
        
        end process;
    
        end architecture registrador_tb;