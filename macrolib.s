.macro marks_count(%text)
	mv a0 %text
	jal marks_count
.end_macro 

.macro read_from_file(%file_name)
	mv a0 %file_name
	jal read_from_file
.end_macro 

.macro write_file(%text %file_name)
	mv t0 %text
	mv a1 %file_name
	mv a0 t0
	jal write_file
.end_macro 

.macro remove_n(%file_name)
	li t4 '\n'
	mv t5 %file_name
	loop:
    		lb t6 (t5)
		beq t4 t6 replace
		addi t5 t5 1
		j loop
	replace:
    		sb zero (t5)
.end_macro 

.macro strlen(%x %save_reg)
	mv t0 %x
	li t1 0
	loop:
		lb t2 (t0)
		beqz t2 end
		plus1(t1)
		plus1(t0)
		j loop
	end:
	mv %save_reg t1
.end_macro 

.macro plus1(%n)
	addi %n %n 1
.end_macro 



.macro read_str(%x %buf)
	mv t0 %x
	mv t1 %buf
	mv a0 t0
	mv a1 t1
	li a7 8
	ecall
.end_macro

.macro read_str_dial(%x %buf %mes)
.data
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

.macro print_str (%x)
.data
str:	.asciz %x
.text
	push (a0)
	li a7, 4
	la a0, str
	ecall
	pop (a0)
.end_macro

.macro print_char(%x)
	push(a0)
	li a7, 11
	li a0, %x
	ecall
	pop(a0)
.end_macro


.macro newline
	print_char('\n')
.end_macro

# Завершение программы
.macro exit
    li a7, 10
    ecall
.end_macro

# Сохранение заданного регистра на стеке
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

# Выталкивание значения с вершины стека в регистр
.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro clear(%x %n)
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

.macro mark_equal(%dst %mark)
	push(a0)
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

.macro save_mark(%dst %numb)
	push(s0)
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
	max_pow_loop:
		beqz s1 max_pow_end
		mv s1 %numb
		mul s0 s0 s2
		div s1 s1 s0
		j max_pow_loop
	max_pow_end:
	div s0 s0 s2
	save_loop:
		beqz s0 save_end
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

.eqv READ_ONLY	0	# Открыть для чтения
.eqv WRITE_ONLY	1	# Открыть для записи
.eqv APPEND	    9	# Открыть для добавления
.macro open(%file_name, %opt)
	
    	li a7 1024
    	mv a0 %file_name
    	li a1 %opt        	# Открыть для чтения (флаг = 0)
    	ecall             		# Дескриптор файла в a0 или -1)
.end_macro

.macro read(%file_descriptor, %strbuf, %size)
    li   a7, 63       	# Системный вызов для чтения из файла
    mv   a0, %file_descriptor       # Дескриптор файла
    la   a1, %strbuf   	# Адрес буфера для читаемого текста
    li   a2, %size 		# Размер читаемой порции
    ecall             	# Чтение
.end_macro

.macro read_addr_reg(%file_descriptor, %reg, %size)
    li   a7, 63       	# Системный вызов для чтения из файла
    mv   a0, %file_descriptor       # Дескриптор файла
    mv   a1, %reg   	# Адрес буфера для читаемого текста из регистра
    li   a2, %size 		# Размер читаемой порции
    ecall             	# Чтение
.end_macro

.macro close(%file_descriptor)
    li   a7, 57       # Системный вызов закрытия файла
    mv   a0, %file_descriptor  # Дескриптор файла
    ecall             # Закрытие файла
.end_macro

.macro allocate(%size)
    li a7, 9
    li a0, %size	# Размер блока памяти
    ecall
.end_macro


