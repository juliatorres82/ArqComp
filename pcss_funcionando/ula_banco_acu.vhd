library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_banco_acu is
    port(

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

end entity ula_banco_acu;


architecture a_ula_banco_acu of ula_banco_acu is

    component ULA is
       port(
        acumulador_in  : in unsigned(15 downto 0); 
        B              : in unsigned(15 downto 0);  
        opcode         : in unsigned(3 downto 0);
        borrow_in      : in std_logic;             
        outULA         : out unsigned(15 downto 0);
        eh_igual       : out std_logic
        );
    end component;

    component acumulador is
        port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        data_in : in unsigned(15 downto 0); 
        data_out: out unsigned(15 downto 0) 
    );
    end component;

    component bancoRegistradores is
        port (
        clk     : in std_logic;
        rst     : in std_logic;
        wr_en   : in std_logic;
        reg_r   : in unsigned(3 downto 0) := (others => '0'); 
        data_wr : in unsigned(15 downto 0) := (others => '0'); 
        data_out: out unsigned(15 downto 0)  
    );
    end component;
    
    -- sinais:
    signal data_out_reg : unsigned(15 downto 0);
    signal out_acu      : unsigned(15 downto 0);
    signal data_out_ula : unsigned(15 downto 0);
    signal mux_to_acu   : unsigned(15 downto 0); -- novo sinal

begin

    -- MUX: seleciona entre dataWR_reg (valor direto) e saída da ULA
    process(dataWR_reg, data_out_ula, load_in_acc)
    begin
        if load_in_acc = '1' then
            mux_to_acu <= dataWR_reg;
        else
            mux_to_acu <= data_out_ula;
        end if;
    end process;

    bancoo: BancoRegistradores
        port map(
            clk      => clk,
            rst      => rst,
            wr_en    => wr_en_reg,
            reg_r    => reg_r,
            data_wr  => dataWR_reg,
            data_out => data_out_reg
        );

    acuu: acumulador
        port map(
            clk      => clk,
            rst      => rst,
            wr_en    => wr_en_acu,
            data_in  => mux_to_acu,        
            data_out => out_acu
        );

    ulaa: ULA
        port map(
            acumulador_in  => out_acu,
            B              => data_out_reg,
            opcode         => opcode,
            borrow_in      => borrow_in,
            outULA         => data_out_ula,
            eh_igual       => eh_igual
        );

    data_out <= out_acu;

end architecture;
