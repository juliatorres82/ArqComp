#!/bin/bash 
# para não ter q executar manualmente no terminal
ghdl -a teste.vhd
ghdl -a teste_tb.vhd
ghdl -r teste_tb --wave=teste.ghw
gtkwave teste.ghw sinais.gtkw

#chmod +x run.sh
#./run.sh

