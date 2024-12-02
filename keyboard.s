.eqv NAME_SIZE 256
.data 
file_read_error: .asciz "An error occurred while reading the file. Please enter the file again.\n"
file_write_error: .asciz "An error occurred while writing in the file. Please enter the file again.\n"
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
	read_str_dial(a0, a1, "Enter full read file path: ")	# Get read file path from user
	remove_n(a0)						# Remove \n from it
	la a0 file_name
	read_from_file(a0)					# Get files text
	la a2 file_name
	strlen(a2, a1)
	clear(a2, a1)						# Clear file_name
	li a1 -1
	bne a1 a0 end_read
	li a7 4
	la a0 file_read_error
	ecall
	j read							# If error occured, user inputs again
	end_read:
    	marks_count(a0)						# Counting marks
    	mv s0 a0
	want_print(a0)						# If user wants to print result, user enters Y or y
	write:
	la a2 file_name
	li a1 NAME_SIZE
	read_str_dial(a2, a1, "Enter full write file path: ")	# Get write file path from user
	remove_n(a2)
	la a1 file_name
	mv a0 s0
	write_file(a0 a1)					# Write marks count to file
	li a1 -1
	bne a0 a1 end_keyboard
	la a2 file_name
	strlen(a2, a1)
	clear(a2, a1)
	li a7 4
	la a0 file_write_error
	ecall
	j write							# If error occured, user inputs again
	end_keyboard:
	pop(s0)
	pop(ra)
	ret
	