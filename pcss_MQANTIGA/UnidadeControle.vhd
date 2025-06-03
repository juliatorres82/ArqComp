library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity UnidadeControle is
    Port (
        clk        : in  std_logic;
        reset      : in  std_logic;
        instr      : in  unsigned(15 downto 0);
        borrow_in  : in  std_logic;

        ula_opcode : out unsigned(3 downto 0);
        acc_write  : out std_logic;
        mem_write  : out std_logic;
        reg_src    : out unsigned(3 downto 0);
        reg_dst    : out unsigned(3 downto 0);
        pc_write   : out std_logic
    );
end UnidadeControle;

architecture a_UnidadeControle of UnidadeControle is
    type state_type is (FETCH, DECODE, EXECUTE, MEMORY, WRITE_BACK);
    signal state : state_type := FETCH;

    signal instr_reg : unsigned(15 downto 0);
    signal opcode    : unsigned(3 downto 0);
begin
    process(clk, reset)
    begin
        if reset = '1' then
            state      <= FETCH;
            pc_write   <= '0';
            acc_write  <= '0';
            mem_write  <= '0';
        elsif rising_edge(clk) then
            case state is

                when FETCH =>
							pc_write <= '1';
							state    <= DECODE;

                when DECODE =>
							instr_reg <= instr;
							opcode    <= instr(15 downto 12);
							reg_src   <= instr(11 downto 8);
							reg_dst   <= instr(7 downto 4);
							pc_write  <= '0';
							state     <= EXECUTE;

					when EXECUTE =>
							ula_opcode <= opcode;
							if opcode = "1001" then
								state <= MEMORY; -- só sw (1001) exige acesso à memória
							else
								state <= WRITE_BACK;
							end if;

					when MEMORY =>
							mem_write <= '1';  -- ativa escrita na RAM
							state     <= FETCH;
							mem_write <= '0';  -- desativa após 1 ciclo


					when WRITE_BACK =>
							acc_write <= '1';
							state     <= FETCH;
							acc_write <= '0';

            end case;
        end if;
    end process;
end a_UnidadeControle;