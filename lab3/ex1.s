addi s0, zero, 3

li a7, 5 #syscall 5: lê inteiro do teclado
ecall
mv t0, a0 #salva o inteiro lido em t0

mul t0, t0, s0  #multiplica o inteiro lido por 3
mv a0, t0  #move de volta para a0 (syscall só atua sobre a0)
li a7, 1 #syscall 1: escreve inteiro
ecall
