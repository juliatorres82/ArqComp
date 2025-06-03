addi s1, zero, 0 # colocar qualquer valor
addi s2, zero, 31 # coloca qualquer valor
addi s3, zero, 0
addi s4, zero, 32 #cnte
addi s5, zero, 0  #cnte


    bge s1, s5, comp1
    bge s1, s5, comp2


caso1: 
    addi s3, zero, 1 # s2 > 32
    j end

caso2: 
    addi s3, zero, 2 # 32 == s2
    j end

caso3:
     addi s3, zero, 3
     j end

caso4: 
    addi s3, zero, 4
    j end

caso5:
     addi s3, zero, 5
     j end

caso6: 
    addi s3, zero, 6
    j end


comp1:
    beq s2, s4, caso2
    bge s2, s4, caso1
    blt s2, s4, caso3

comp2:
    beq s2, s4, caso5
    bge s2, s4, caso4
    blt s2, s4, caso6

end:



