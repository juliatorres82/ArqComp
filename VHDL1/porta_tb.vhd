library ieee;
use ieee.std_logic_1164.all;

--testbench - arquivo de teste
entity porta_tb is
end;

architecture a_porta of porta_tb is
    component porta
    -- a seção "component" indica q vamos usar um componente pronto
    -- de outro arquivo; temos q indicar exatamente a msm interface
    port(
        in_a : in std_logic;
        in_b : in std_logic;
        a_e_b: out std_logic
    );
    end component;
    -- signal faz as lingações entre pinos
    -- mesmo nome dos pinos para facilitar
    signal in_a, in_b, a_e_b: std_logic;
    begin
        uut: porta port map ( 
        -- uut é o nome da INSTANCIA do componente porta
            in_a => in_a,
            in_b => in_b,
            a_e_b => a_e_b
        -- mapeamos TODOS os pinos para sinais criados NESTE arquivo
        );
    -- process: seção de eventos sequenciais 
    process
    begin
        in_a <= '0';
        in_b <= '0';
        wait for 50 ns;

        in_a <= '0';
        in_b <= '1';
        wait for 50 ns;

        in_a <= '1';
        in_b <= '0';
        wait for 50 ns;

        in_a <= '1';
        in_b <= '1';
        wait for 50 ns;
        wait; -- todo process termina com isso

    end process;
end architecture;
