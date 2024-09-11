.data
D: .word 1 2 3 4 5 6 7 8 9 10 #arreglo de prueba
.text
addi $s0, $zero, 0 #se asume que es a
addi $s1, $zero, 1 #se asume que es b 
addi $s2, $zero, 0 #index, dirección base de memoria de D
addi $t0, $zero, 10 

loop:
	slt $t1, $s0, $t0 #ve si a < 10
	beq $t1, 0, done #si a no es menor a 10, se va a done
	add $t3, $s0, $s1 #si a es menor a 10, hace a + b
	sw $t3, D($s2) #guarda la suma en D[a]
	#imprime el arreglo a medida que avanza
	li $v0, 1
	move $a0, $t3
	syscall
	#sección de avance en el arreglo
	add $s2, $s2, 4 #avanza una posición en el arreglo usando memoria
	add $s0, $s0, 1 #aumenta en 1 el valor del index, que en este caso es a
	j loop
	
done:

	
