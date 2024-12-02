.macro marks_count(%text) 		# Pass text from file(%text) return a0(string with different marks number)
	mv a0 %text
	jal marks_count
.end_macro 

.macro want_print(%text) 		# Pass text from file(%text) return nothing
	push(a0)
	print_str("Do you want to print results Y/N? ")
	mv t0 %text
	li a7 12
	ecall
	newline()
	li t1 'Y'
	li t2 'y'
	beq a0 t1 print
	beq a0 t2 print			# If user enter "Y" or "y" print result, else exit macro
	j not_print
	print:
	mv a0 t0
	li a7 4
	ecall
	not_print:
	pop(a0)
.end_macro 


.macro run_test(%input_file_path %otput_file_path) 	# Pass file paths for read(%input_file_path) and write(%otput_file_path)
	.data 												# return nothing
	input_file_path: .asciz %input_file_path
	otput_file_path: .asciz %otput_file_path
	.text
	push(s0)
	print_str("Marks from file: ")
	la a0 input_file_path
	li a7 4
	ecall
	newline()
	read_from_file(a0)		# Run macro with input_file_path (read from test file)
	marks_count(a0)
	mv s0 a0
	li a7 4
	ecall				# Print marks from test file
	la a1 otput_file_path
	write_file(a0 a1)		# Run macro with output_file_path (write to test file)
	newline()
	pop(s0)
.end_macro 


.macro read_from_file(%file_name)	# Pass path to read file(%file_name) return a0(text from file)
	mv a0 %file_name
	jal read_from_file
.end_macro 

.macro write_file(%text %file_name)	# Pass string with different marks number(%text) and path to write file(%file_name)
	mv t0 %text											# return nothing
	mv a1 %file_name
	mv a0 t0
	jal write_file
.end_macro 

.macro remove_n(%file_name)		# Pass path to file(%file_name), return nothing, change %file_name
	li t4 '\n'
	mv t5 %file_name
	loop:
    		lb t6 (t5)
		beq t4 t6 replace	# If string character is equal '\n' replace it with null terminator
		addi t5 t5 1
		j loop
	replace:
    		sb zero (t5)
.end_macro 

.macro strlen(%x %save_reg)		# Pass string(%x) and register to store length of string (%save_reg)
	mv t0 %x											# return value in %save_reg
	li t1 0
	loop:				# Count each character in string
		lb t2 (t0)
		beqz t2 end
		plus1(t1)
		plus1(t0)
		j loop
	end:
	mv %save_reg t1
.end_macro 

.macro plus1(%n)			# Pass number(%n) return ++%n
	addi %n %n 1
.end_macro 

.macro read_str(%x %buf)		# Pass address to save string(%x) and max number of input character(%buf)
	mv t0 %x											# return string in %x 
	mv t1 %buf
	mv a0 t0
	mv a1 t1
	li a7 8
	ecall
.end_macro

.macro read_str_dial(%x %buf %mes)	# Pass address to save string(%x), max number of input character(%buf)
.data									# and message to show to user(%mes), return string in %x 
str:	.asciz %mes
.text 
	push(a0)
	push(a1)
	push(a2)
	mv t0 %x
	mv t1 %buf
	la a0 str
	mv a1 t0
	mv a2 t1
	li a7 54
	ecall
	pop(a2)
	pop(a1)
	pop(a0)
.end_macro 

.macro print_str (%x)			# Pass string to print (%x) like "Hello" not register, return nothing
.data
str:	.asciz %x
.text
	push (a0)
	li a7, 4
	la a0, str
	ecall
	pop (a0)
.end_macro

.macro print_char(%x)			# Pass character to print (%x) like 'a' not register, return nothing
	push(a0)
	li a7, 11
	li a0, %x
	ecall
	pop(a0)
.end_macro


.macro newline				# Pass nothing, return nothing, just move to the new line
	print_char('\n')
.end_macro

.macro push(%x)				# Pass register to save on the stack, return nothing
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro pop(%x)				# Pass register to load from the stack, return value in %x
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro clear(%x %n)			# Pass address to clear memory and number of bytes to clear, return nothing
	mv t0 %x
	mv t1 %n
	loop:
		blez t1 end
		sb zero (t0)
		addi t1 t1 -1
		plus1(t0)
		j loop
	end:
.end_macro 

.macro mark_equal(%dst %mark)		# Pass address to save string(%dst) and mark(%mark), return nothing
	push(a0)							# just add to %dst "{%mark} = " shift it in 4 bytes
	sb %mark (%dst)
	plus1(%dst)
	li a0 ' '
	sb a0 (%dst)
	plus1(%dst)
	li a0 '='
	sb a0 (%dst)
	plus1(%dst)
	li a0 ' '
	sb a0 (%dst)
	plus1(%dst)
	pop(a0)
.end_macro 

.macro save_mark(%dst %numb)		# Pass address save number(%dst) and number of marks(%numb), return nothing
	push(s0)							# just add to %dst %numb and shift it in %numb length bytes
	push(s1)
	push(s2)
	li s0 1
	mv s1 %numb
	li s2 10
	bnez %numb max_pow_loop
	li %numb 48
	sb %numb (%dst)
	plus1(%dst)
	j save_end
	max_pow_loop:			# Calculating max power of %numb, like for 200 it will be 100
		beqz s1 max_pow_end
		mv s1 %numb
		mul s0 s0 s2
		div s1 s1 s0
		j max_pow_loop
	max_pow_end:
	div s0 s0 s2
	save_loop:			# Save %numb by bytes, like in 201 save first 201/100 % 10 = 2, then 201/10 % 10=0
		beqz s0 save_end									# then 201/1 % 10 = 1
		div s1 %numb s0
		rem s1 s1 s2
		div s0 s0 s2
		addi s1 s1 48
		sb s1 (%dst)
		plus1(%dst)
		j save_loop
	save_end:
	pop(s2)
	pop(s1)
	pop(s0)
.end_macro 

.eqv READ_ONLY	0
.eqv WRITE_ONLY	1
.eqv APPEND 9
.macro open(%file_name, %opt)		# Pass file path to open(%file_name) and option for read/write/append(%opt)
    	li a7 1024									# return a0(file descriptor)
    	mv a0 %file_name
    	li a1 %opt
    	ecall
.end_macro

.macro read_addr_reg(%file_descriptor, %reg, %size)	# Pass file descriptor(%file_descriptor), buffer address 
    	li   a7, 63					# in which the file will be saved(%strbuf), size of read character(%size)
    	mv   a0, %file_descriptor			# return text in bufers address, a0(lenght read)
    	mv   a1, %reg
    	li   a2, %size
    	ecall
.end_macro

.macro close(%file_descriptor)		# Pass file descriptor(%file_descriptor), return nothing
    	li   a7, 57	
    	mv   a0, %file_descriptor
    	ecall
.end_macro

.macro allocate(%size)			# Pass number of bytes to allocate(%size), return a0(address of allocated block)
    	li a7, 9
    	li a0, %size
    	ecall
.end_macro