library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

--couting leading zeroes
--subtração com borrow (ok)
--cmpi (ok)

entity ULA is 
    port(
        acumulador_in  : in unsigned(15 downto 0);  -- valor do AC
        B              : in unsigned(15 downto 0);  -- valor do registrador B
        opcode         : in unsigned(3 downto 0);
        borrow_in      : in std_logic;              -- para SUBB
        outULA         : out unsigned(15 downto 0);
        zero           : out std_logic
    );
end entity;

architecture a_ULA of ULA is

    signal temp_result : unsigned(15 downto 0);
    signal clz_count   : integer range 0 to 16;

begin
    temp_result <=
                    acumulador_in + B when opcode = "1111" else
                    acumulador_in - B when opcode = "0001" and borrow_in = '0' else
                    acumulador_in - B - 1 when opcode = "0001" and borrow_in = '1' else
                    (others => '0'); -- 0000 reseta, por ex

    zero <= --cmpi
                    '1' when acumulador_in - B = "0000000000000000" else 
                    '0';

    outULA <= temp_result;
end architecture;
