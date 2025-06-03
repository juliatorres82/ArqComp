//percorrer a memória de  0x10010000 a 0x10020000
//em palavras de 4 bytes 
//contar QUANTAS dessas palavras têm o valor 0x00000000

/* 
1. definimos os endereços inicial e final
2. percorremos a memória, lendo uma palavra por vez (de 4 em 4 bits)
3. verificamos se o valor lido é igual a 0x00000000
4. se for, incrementamos o contador
5. percorremos até o endereço final
*/

li t0, 0x10010000  # endereço inicial
li t1, 0x10020000  # endereço final

addi s0, zero, 0  # contador
addi s1, zero, 4  # incremento do ponteiro (cada palavra tem 4 bytes)
addi s2, zero, 0x00000000 # valor a verificar

loop:
    bge t0, t1, end   #se t0 >= t1, sai do loop

    lw a0, 0(t0)      #lê a palavra que está em t0
    beq a0, s2, inc   #se a0 == 0x00000000, i++

    addi t0, t0, s1   #incrementa o ponteiro (próxima palavra)
    j loop            #volta para o loop
    


inc: 
    addi s0, s0, 1    #incrementa o contador
    addi t0, t0, s1   #incrementa o ponteiro (próxima palavra)
    j loop            #volta para o loop

end: