.text
li t0, 0           # soma = 0
li s0, 0           # i = 0
li s1, 10          # número de entradas
li s2, 1           # incremento de i

loop:
li a7, 5           # syscall 5: ler inteiro
ecall
add t0, t0, a0     # soma += número lido
add s0, s0, s2     # i++

bne s0, s1, loop   # se i != 10, repete

# exibir a soma final
mv a0, t0
li a7, 1           # syscall 1: imprimir inteiro
ecall

end:
