#Escribe un programa en MIPS que calcule la multiplicación de dos enteros mediante la implementación de subrutinas.
.data
resultado: .asciiz "Resultado multiplicacion: "
salto: .asciiz "\n"
.text

#Numeros enteros de prueba en $t0 y $t1
addi $t0, $zero, 10
addi $t1, $zero, -2

#caso base alguno sea 0
beqz $t0, esCero
beqz $t1, esCero

#en $t2 y $t3 se guardan "signos"
slt $t2, $t0, $zero     # si $t0 < 0, $t2 da 1
slt $t3, $t1, $zero     #si $t1 < 0, $t3 da 1

#Casos negativos
beq $t2, $t3, argumentoAmbosNegativos
bne $t2, $zero, argumentoIzq 
bne $t3, $zero, argumentoDer
#y si no cumple con ningun caso negativo:
j argumentoPositivos

#caso negativo izquierda
argumentoIzq:
	move $a1, $t0
	move $a2, $t0
	j multiplicacionNegativaIzq
	
argumentoPositivos:
	move $a1, $t0
	move $a2, $t0
	j multiplicacion

#caso negativo derecha
argumentoDer:
	move $a1, $t1
	move $a2, $t1
	j multiplicacionNegativaDer
	
argumentoAmbosNegativos:
        slt $t2, $t0, $zero    # si $t0 < 0, $t2 da 1
        beq $t2, $zero, argumentoPositivos
	#convierte a positivos
	sub $t6, $zero, $t0      
	sub $t7, $zero, $t1 	
	move $a1, $t6
	move $a2, $t6
	j multiplicacionNegativaAmbos 

multiplicacion:
	beq $t1, 1, exit
	jal suma
	#a2 es el acumulador
	move $a2, $v0
	sub $t1, $t1, 1
	j multiplicacion 

multiplicacionNegativaIzq:
	beq $t1, 1, exit
	#argumentos pasados al inicio
	jal suma 
	move $a2, $v0
	sub $t1, $t1, 1
	j multiplicacionNegativaIzq	
	
multiplicacionNegativaDer:
	beq $t0, 1, exit
	#argumentos pasados al inicio
	jal suma 
	move $a2, $v0
	sub $t0, $t0, 1
	j multiplicacionNegativaDer
	
multiplicacionNegativaAmbos:
	beq $t7, 1, exit
	jal suma
	move $a2, $v0
	sub $t7, $t7, 1
	j multiplicacionNegativaAmbos
	
suma:
# ingresa el acumulador y el valor de $t0
	add $t2, $a1, $a2
	move $v0, $t2
	jr $ra
	     
esCero:
    #Mensaje resultado
    li $v0, 4
    la $a0, resultado
    syscall

   #Imprimir el resultado
    li $v0, 1
    move $a0, $zero
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
    move $a0, $a2
    syscall
    
# Terminar el programa
    li $v0, 10
    syscall
