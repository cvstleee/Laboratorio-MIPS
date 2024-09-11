.data
resultado: .asciiz "Resultado factorial: "
salto: .asciiz "\n"

.text

# Cargar el número para calcular el factorial
addi $t0, $zero, 3   # n
addi $t1, $zero, 2   #el 2do que multiplica 
addi $t3, $zero, 1   # Valor factorial (resultado acumulado)
add $t4, $t1, $zero  #guarda el que se va multiplicando antes de usarlo en la multiplicación

addi $t8, $zero, 1 #factorial actual
addi $t9, $zero, 1 #resultado factorial


factorial:
   addi $a2, $zero, 0
   move $a1, $t8 
   move $a2, $t9
   jal multiplicacion
   #acumulador factorial con resultado multiplicacion
   move $t9, $a2
   beq $t8, $t0, exit
   #contador
   addi $t8, $t8, 1  
   j factorial

multiplicacion:
	beq $t1, 1, terminoMul
	jal suma
	#a2 es el acumulador que va guardando la multiplicacion
	move $a2, $v0
	sub $t1, $t1, 1
	j multiplicacion 
	
terminoMul:
	jr $ra #vuelve a donde fue llamado multiplicacion

			
suma:
	add $t2, $a1, $a2
	move $v0, $t2
	jr $ra

exit: 
#Mensaje resultado
    li $v0, 4
    la $a0, resultado
    syscall

 #Imprimir el resultado
    li $v0, 1
    move $a0, $t9
    syscall
    
# Terminar el programa
    li $v0, 10
    syscall
