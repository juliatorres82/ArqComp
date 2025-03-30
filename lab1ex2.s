addi s0, zero, 1  # s0 - valor atual mult
addi s1, zero, 1  # s1 - contador da multiplicação
addi s2, zero, 1  # s2 - número atual do fat
addi s3, zero, 8  # 8!
addi s5, zero, 1  # fator da soma 

fat:
    addi s1, zero, 0   # reinicia contMult
    add s5, zero, s0   # s5 = s0

    mult:
        add s0, s0, s5 # s0 += s5
        addi s1, s1, 1
        bne s1, s2, mult

        addi s2, s2, 1 
        bne s2, s3, fat





