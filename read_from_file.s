.eqv TEXT_SIZE 512
.data
 er_name_mes:    .asciz "Incorrect file name\n\n"
er_read_mes:    .asciz "Incorrect read operation\n\n"
.include "macrolib.s"
.global read_from_file
.text 
read_from_file:
	push(ra)
	push(s0)
	push(s1)
	push(s2)
	push(s3)
	push(s4)
	push(s5)
	push(s6)
	push(s7)
	mv s7 a0
	open(a0, READ_ONLY)	# Open file for read
	li s1 -1
    	beq a0 s1 er_name
    	mv s0 a0
    	allocate(TEXT_SIZE)	# Add 512 bytes to the heap
    	mv s3, a0
    	mv s5, a0
    	li s4, TEXT_SIZE
    	mv s6, zero
	read_loop:		# Read 512 characters from file, then if it isn't end of the file, add another 512 bytes in heap 
   		read_addr_reg(s0, s5, TEXT_SIZE)
    		beq a0 s1 er_read
    		mv s2 a0
    		add s6, s6, s2		
    		bne s2 s4 end_loop
    		allocate(TEXT_SIZE)	# Add another 512 bytes
    		add s5 s5 s2
   		j read_loop
	end_loop:
    	close(s0)		# Close read file
    	mv t0 s3
    	add t0 t0 s6
    	addi t0 t0 1
    	sb zero (t0)
    	mv a0 s3		# If all ok, a0 = text from file
    	j end_read_from_file
	er_name:		# If file doesn't exist a0 = -1
    	la a0 er_name_mes
    	li a7 4
    	ecall
    	li a0 -1
    	j end_read_from_file
	er_read:		# If error occurred to file exist a0 = -1
    	la a0 er_read_mes
    	li a7 4
    	ecall
    	li a0 -1
    	end_read_from_file:
    	pop(s7)
    	pop(s6)
    	pop(s5)
    	pop(s4)
    	pop(s3)
    	pop(s2)
    	pop(s1)
	pop(s0)
	pop(ra)
	ret