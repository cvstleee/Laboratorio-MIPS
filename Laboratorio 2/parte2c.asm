#Division

.data
resultado: .asciiz "Resultado division: "
salto: .asciiz "\n"
punto: .asciiz "."
.text

#Inicialización de números a dividir
addi $t0, $zero, 8 
addi $t1, $zero, 4
addi $t2, $zero, 0 #acumulador, por cada resta se va sumando
addi $s1, $zero, 0 #solo inicialización

#Casos negativos:
slt $t3, $t0, $zero
slt $t4, $t1, $zero

#caso donde ambos son negativos o positivos
beq $t4, $t3, argumentoAmbosNegativos 
#caso donde alguno de los dos sean negativos
bne $t3, $zero, divisionDividendoNegativo
bne $t4, $zero, divisionDivisorNegativo


divisionPositivos:
	beqz $a1, exit
	addi $t2, $t2, 1
	sub $a1, $a1, $a2
	j divisionPositivos
divisionAmbosNegativos:
	beqz $t4, exit 
	slt $t3, $t4, $t7
	bne $t3, $zero, primerDecimal
	addi $t2, $t2, 1
	sub $t4, $t4, $t7
	j divisionAmbosNegativos
	
divisionDividendoNegativo:
	bne $t3, $zero, convertirPositivoDividendo
	beqz $t0, exitNegativo
	sub $t0, $t0, $t1
	addi $t2, $t2, 1
	j divisionDividendoNegativo

divisionDivisorNegativo:
	bne $t4, $zero, convertirPositivoDivisor
	beqz $t0, exitNegativo
	sub $t0, $t0, $t1
	addi $t2, $t2, 1
	j divisionDivisorNegativo

convertirPositivoDivisor:
	sub $t1, $zero, $t1
	sub $t4, $t4, 1
	j divisionDivisorNegativo

convertirPositivoDividendo:
	sub $t0, $zero, $t0
	sub $t3, $t3, 1
	j divisionDividendoNegativo
	
argumentoPositivos:
	move $a1, $t0
	move $a2, $t1
	j divisionPositivos
	
argumentoAmbosNegativos:
        slt $t3, $t0, $zero
        beq $t3, $zero, argumentoPositivos
	#convierte a positivos
	sub $t4, $zero, $t0     
	sub $t7, $zero, $t1 
	j divisionAmbosNegativos
	
primerDecimal:
	#para la suma
	move $a1, $t4
	move $a2, $t4
	addi $t5, $zero, 10 #multiplica por 10
	
	jal multiplicacion
	move $s2, $a2 #resultado multiplicacion = primer decimal
	sub $t4, $t4, $t7
	addi $t2, $t2, 1 
	slt $t3, $t4, $t7
	beqz $t4, exit #si $t4 queda en 0
	bne $t3, $zero, segundoDecimal #si t6 < t7
	
segundoDecimal:
	move $a1, $t4
	move $a2, $t4
	addi $t5, $zero, 10 #multiplica por 10
	jal multiplicacion
	move $s1, $a2 #resultado multiplicacion = segundo decimal
	slt $t3, $t4, $t7
	bne $t3, $zero, exit #si t6 < t7
	j exit
	
multiplicacion:
	beq $t5, 1, terminoMul
	jal suma
	#a2 es el acumulador que va guardando la multiplicación
	move $a2, $v0
	sub $t5, $t5, 1
	j multiplicacion 
	
terminoMul:
	jr $ra #vuelve a donde fue llamado multiplicación

			
suma:
	add $t2, $a1, $a2
	move $v0, $t2
	jr $ra
	
	
exitNegativo:

	sub $t2, $zero, $t2

#Mensaje resultado
    li $v0, 4
    la $a0, resultado
    syscall

 #Imprimir el resultado
    li $v0, 1
    move $a0, $t2
    syscall
    
# Terminar el programa
    li $v0, 10
    syscall

exit: 
#Mensaje resultado
    li $v0, 4
    la $a0, resultado
    syscall

#Imprimir el resultado
    li $v0, 1
    move $a0, $t2
    syscall
    
#Mensaje punto
    li $v0, 4
    la $a0, punto
    syscall
    
#Imprimir el primer decimal
    li $v0, 1
    move $a0, $s2
    syscall
    
#Imprimir el segundo decimal
    li $v0, 1
    move $a0, $s1
    syscall
    
#Terminar el programa
    li $v0, 10
    syscall

