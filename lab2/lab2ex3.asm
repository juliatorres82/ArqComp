
.data
    .org 0x10010100       # força os dados a começar em 0x10010100
    .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
    .word 11, 12, 13, 14, 15, 16, 17, 18, 19, 20
    .word 21, 22, 23, 24, 25, 26, 27, 28, 29, 30
    .word 31, 32, 33, 34, 35, 36, 37, 38, 39, 40

.text
.globl main

main:
	li a0, 0
	li a1, 40
	li t0, 0
	
	li s0, 0x10010100    # endereço de onde a word será retirada
	li s1, 0x10011100    # endereço de onde a word será armazenada
	
	loop:
	    lw t0, 0(s0)    # carrega a word do endereço 0+s0 em t0
	    sw t0, 0(s1)    # armazena o valor de t0 no endereço de 0+s1
	    addi s0, s0, 4   
	    addi s1, s1, 4
	    addi a0, a0, 1  # cont++
	    
	    bne a0, a1, loop
	    
