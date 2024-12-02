.eqv TEXT_SIZE 4096
.data 
 er_name_mes:    .asciz "Incorrect file name\n"
.global write_file
.include "macrolib.s"

.text 
write_file:
	push(ra)
	push(s0)
	push(s1)
	mv s0 a0
	open(a1, WRITE_ONLY)
    	li s1 -1
    	beq a0 s1 er_name
    	mv s1 a0 
    	li a7, 64
    	mv a0, s1 
    	mv a1, s0
    	li a2, TEXT_SIZE
    	ecall
    	close(s1)
    	li a0 1
    	j write_end
    	er_name:
    		la a0 er_name_mes
    		li a7 4
    		ecall
    		li a0 -1
    	write_end:
    	pop(s1)
    	pop(s0)
    	pop(ra)
    	ret