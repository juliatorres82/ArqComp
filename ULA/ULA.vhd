library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ULA is 
    port(
        acumulador_in  : in unsigned(15 downto 0);  -- operando principal
        B              : in unsigned(15 downto 0);  -- é o segundo operando
        opcode         : in unsigned(3 downto 0);
        borrow_in      : in std_logic; -- vamos usar p SUBB
        acumulador_out : out unsigned(15 downto 0);
        outULA         : out unsigned(15 downto 0);
        eh_igual       : out std_logic
    );
end entity;

architecture a_ULA of ULA is
    signal temp_result : unsigned(15 downto 0);

    
begin
    process(acumulador_in, B, opcode, borrow_in)
    variable clz_count : integer := 0;
    begin

        case opcode is
            when "1111" =>  --soma 
                temp_result <= acumulador_in + B;
                eh_igual <= '0';

            when "0000" =>  --subtração 
                temp_result <= acumulador_in - B;
                eh_igual <= '0';

            when "1001" =>  --SUBB (A - B - borrow)
                if borrow_in = '1' then
                    temp_result <= acumulador_in - B - 1;
                else
                    temp_result <= acumulador_in - B;
                end if;
                eh_igual <= '0';

            when "1010" =>  -- CMPI (vamos usar em branches - verifica se A == B; não usa sub p não alterar o reg.)
                temp_result <= (others => '0'); -- pq nao usamos o resultado, só precisamos da flag
                if acumulador_in = B then
                    eh_igual <= '1';
                else
                    eh_igual <= '0';
                end if;

            when "1011" =>  --CLZ (Count Leading Zeros de A)
                clz_count := 0;
                if acumulador_in(15) = '1' then       -- se msb é 1, n tem 0 à esq.
                    clz_count := 0;
                elsif acumulador_in(14) = '1' then    -- se bit(14) é '1': 1 zero...
                    clz_count := 1;
                elsif acumulador_in(13) = '1' then    
                    clz_count := 2;
                elsif acumulador_in(12) = '1' then
                    clz_count := 3;
                elsif acumulador_in(11) = '1' then
                    clz_count := 4;
                elsif acumulador_in(10) = '1' then
                    clz_count := 5;
                elsif acumulador_in(9) = '1' then
                    clz_count := 6;
                elsif acumulador_in(8) = '1' then
                    clz_count := 7;
                elsif acumulador_in(7) = '1' then
                    clz_count := 8;
                elsif acumulador_in(6) = '1' then
                    clz_count := 9;
                elsif acumulador_in(5) = '1' then
                    clz_count := 10;
                elsif acumulador_in(4) = '1' then
                    clz_count := 11;
                elsif acumulador_in(3) = '1' then
                    clz_count := 12;
                elsif acumulador_in(2) = '1' then
                    clz_count := 13;
                elsif acumulador_in(1) = '1' then
                    clz_count := 14;
                elsif acumulador_in(0) = '1' then     
                    clz_count := 15;
                else                                  
                    clz_count := 16;
                end if;

                temp_result <= to_unsigned(clz_count, 16);
                eh_igual <= '0';
            when others =>
                temp_result <= (others => '0');
                eh_igual <= '0';
                
        end case;

        outULA <= temp_result;
        acumulador_out <= temp_result;
    end process;
end architecture;