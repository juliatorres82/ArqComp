    addi s1, zero, 0   # contador
    addi s2, zero, 0   # somador do quadrado Sq
    addi s3, zero, 6   # fim do i
    addi s4, zero, 0   # somador total S

    sum:
        add s4, s4, s2   # S = S + Sq
        addi s2, zero, 0 # Sq = 0
        addi s1, zero, 0 # contador = 0
        addi s0, s0, 1   # i++
    exp:
        add s2, s2, s0   # Sq = Sq + i
        addi s1, s1, 1   # contador++
        bne s1, s0, exp  
        bne s0, s3, sum 
        