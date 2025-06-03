addi a0, zero, 0   # a0 = contador
li t1, 1000       # final 
li t2, 0x10011234 # ponteiro para o endereço inicial


loop:
    lw t0, 0(t2)   # carrega o valor do endereço em t0
    sw a0, 0(t2)   # armazena o valor de a0 no endereço
    addi a0, a0, 1 # contador++
    addi t2, t2, 4 # ponteiro++
    bne a0, t1, loop # se contador != final, volta para o loop