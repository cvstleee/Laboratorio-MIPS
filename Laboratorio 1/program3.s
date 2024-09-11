.data
arr: .word 7 8 10 12 5 #es el arreglo
arrlen: .word 20 #es el largo del arreglo representado en bits

.text

addi $t0, $zero, 0 #se asume que es evensum
lw $s1, arrlen #lee y guarda el largo del arreglo
la $s0, 0 #se usa la dirección base como index


loop:
	beq $s0, $s1, done #si el index llega al final del arreglo, salta a done
	lw $t2, arr($s0) #lee lo que se encuentra en la dirección de memoria de $s0 y lo guarda en $t2
	andi $t3, $t2, 1 #revisa si el número es par
	beq $t3, $zero, suma #si el resultado de lo anterior da 0 salta a suma, ya que el número sería par
	addi $s0, $s0, 4 #avanza la posición de memoria
	j loop #salta a loop para repetir el ciclo
	
suma:
	add $t0, $t0, $t2 #suma  el valor del array en cierta posición con evensum
	addi $s0, $s0, 4 #avanza la posición de memoria
	j loop
	
done:
	#sección que imprime el valor de $t0, lo que sería evensum
	li $v0, 1
	move $a0, $t0
	syscall
	
	li $v0, 10
	syscall
