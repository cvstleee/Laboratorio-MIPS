addi $s0, $zero, 0 #se asume que es a
addi $s1, $zero, 1 #se asume que es z
addi $t0, $zero, 10 


while:
	beq $s1, $t0, done #si z = 10, salta a done
	add $s0, $s1, $s0 #sino a = a + z
	add $s1, $s1, 1 # z = z + 1
	j while #salto a while para continuar con el ciclo

done:
	#la consola imprime primero el valor de a y después el de z 
	li $v0, 1 
	move $a0, $s0
	syscall
	
	#Imprimir un salto de linea para separar los valores
	li $v0, 4         
	la $a0, espacio   
	syscall           
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	.data
	espacio: .asciiz "\n"  #salto de linea para separar el valor de a y z
