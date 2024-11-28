.eqv NAME_SIZE 256
.data 
file_error: .asciz "An error occurred while reading the file. Please enter the file again.\n"
file_name: .space NAME_SIZE


.include "macrolib.s"
.global keyboard
.text 
keyboard:
	push(ra)
	push(s0)
	read:
	la a0 file_name
	li a1 NAME_SIZE
	read_str_dial(a0, a1, "Enter full read file path: ")
	remove_n(a0)
	la a0 file_name
	read_from_file(a0)
	mv s0 a0
	la a2 file_name
	strlen(a2, a1)
	clear(a2, a1)
	li a1 -1
	bne a1 a0 write
	li a7 4
	la a0 file_error
	ecall
	j read
	write:
	la a2 file_name
	li a1 NAME_SIZE
	read_str_dial(a2, a1, "Enter full write file path: ")
	remove_n(a2)
	la a1 file_name
	mv a0 s0
	write_file(a0 a1)
	pop(s0)
	pop(ra)
	ret
	