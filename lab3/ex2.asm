
.data
numeros: .space 20 # 5 inteiros × 4 bytes = 20 bytes

.text

la t0, numeros    # ponteiro para o primeiro num alocado
addi s1, zero, 4  # incrementador do pomteiro
li s0, 0          # i
addi s2, zero, 3  # fim i
addi a1, zero, 1  # incrementador i 
addi a2, zero, -1 # decrementador i
addi a3, zero, -4 # decrementador do ponteiro


scan:
li a7, 5         # lê inteiro do teclado
ecall
sw a0, 0(t0)     # guarda num no vetor 
add t0, t0, s1   # pont += 4
add s0, s0, a1   # i++
bne s0, s2, scan # continua se i != fim

li s0, 0

print:
add t0, t0, a3     # pont -=4
lw a0, (t0)        # salva conteúdo de t0 em a0
li a7, 1
ecall              # printa inteiro 
add s0, s0, a1     # i++
bne s0, s2, print

end:
li a7, 10        # syscall 10: sair
ecall

