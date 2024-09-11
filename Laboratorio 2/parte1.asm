.data
entero1: .asciiz "Ingrese el primer número entero: " 
entero2: .asciiz "\nIngrese el segundo número entero: " 
msjDiferencia: .asciiz "\nLa diferencia es: "
msjImpar: .asciiz " (Impar)"
msjPar: .asciiz " (Par)"
salto: .asciiz "\n"
msjSumaPar: .asciiz "\nNuevo primer entero: "
msjSumaImpar: .asciiz "\nNuevo segundo entero: "

.text
main:
    # Solicitar el primer número
    li $v0, 4
    la $a0, entero1
    syscall

    # Leer el primer número
    li $v0, 5
    syscall
    move $a1, $v0
    
    # Solicitar el segundo número
    li $v0, 4
    la $a0, entero2
    syscall

    # Leer el segundo número
    li $v0, 5
    syscall
    move $a2, $v0
	
    jal calculoMaximo	    
	                
    jal diferencia

    # $v0 ahora tiene la diferencia
    move $t3, $v0
    
    # Determinar si la diferencia es par o impar
    andi $t3, $t2, 1 # Revisar si el número es par, 0 es par, 1 impar
    beq $t3, 1, impar # Si $t3 es 1 (impar), salta a impar
    j par # Si no es 1 (par), salta a par

calculoMaximo:
	slt $t5, $a1, $a2 
	beq $t5, 1, maximoInt2    
        jr $ra #vuelve al inicio
        
        
maximoInt2:
	move $v0, $a2
	move $a2, $a1
	move $a1, $v0
	jr $ra
	
                
diferencia: 
#aqui adentro se asume que $a1 siempre será el mayor
    sub $t2, $a1, $a2 
    move $v0, $t2     # Guardar la diferencia en $v0 para devolverla
    jr $ra           
    
impar:
    # Imprimir el mensaje de que la diferencia es
    li $v0, 4
    la $a0, msjDiferencia
    syscall
    # Imprimir la diferencia
    li $v0, 1
    move $a0, $t2
    syscall
    # Imprimir que es impar
    li $v0, 4
    la $a0, msjImpar
    syscall
    move $a3, $t2
   
     # Llamar a la subrutina de suma final
    jal sumaEntero
    # $v0 ahora tiene la suma
    move $t4, $v0 #guarda el resultado de la suma en $t4
   
   
    li $v0, 4
    la $a0, msjSumaImpar
    syscall
   #imprimir la suma
    li $v0, 1
    move $a0, $t4
    syscall
    j exit

par:
    # Imprimir el mensaje de que la diferencia es
    li $v0, 4
    la $a0, msjDiferencia
    syscall
    # Imprimir la diferencia
    li $v0, 1
    move $a0, $t2
    syscall
    # Imprimir que es par
    li $v0, 4
    la $a0, msjPar
    syscall
    #$a3 pasa a ser el valor de la diferencia
    move $a3, $t2
    #$a1 ya es el valor del segundo entero, pero estamos usando $a2 en la subrutina
    move $a2, $a1
    # Llamar a la subrutina diferencia
    jal sumaEntero
    # $v0 ahora tiene la suma
    move $t4, $v0 #guarda el resultado de la suma en $t4
    # Imprimir el mensaje de que la suma
    li $v0, 4
    la $a0, msjSumaPar
    syscall
   #imprimir la suma
    li $v0, 1
    move $a0, $t4
    syscall
    j exit

sumaEntero:
#guarda ell resultado en $v0, $a3 es el valor de la diferencia y $a2 uno de los dos enteros según corresponda
	add $v0, $a3, $a2
	jr $ra


exit: 
    # Terminar el programa
    li $v0, 10
    syscall
