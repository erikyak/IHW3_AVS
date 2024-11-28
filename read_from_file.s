.eqv TEXT_SIZE 512
.data
 er_name_mes:    .asciz "Incorrect file name\n"
er_read_mes:    .asciz "Incorrect read operation\n"
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
	open(a0, READ_ONLY)
	li s1 -1
    	beq a0 s1 er_name
    	mv s0 a0       	# Сохранение дескриптора файла
    	allocate(TEXT_SIZE)		# Результат хранится в a0
    	mv s3, a0			# Сохранение адреса кучи в регистре
    	mv s5, a0			# Сохранение изменяемого адреса кучи в регистре
    	li s4, TEXT_SIZE	# Сохранение константы для обработки
    	mv s6, zero
	read_loop:
   		read_addr_reg(s0, s5, TEXT_SIZE)
    		beq a0 s1 er_read	# Ошибка чтения
    		mv s2 a0       	# Сохранение длины текста
    		add s6, s6, s2		
    		bne s2 s4 end_loop
    		allocate(TEXT_SIZE)		# Результат здесь не нужен, но если нужно то...
    		add s5 s5 s2		# Адрес для чтения смещается на размер порции
   		j read_loop				# Обработка следующей порции текста из файла
	end_loop:
    	close(s0)
    	mv t0 s3		# Адрес буфера в куче
    	add t0 t0 s6	# Адрес последнего прочитанного символа
    	addi t0 t0 1	# Место для нуля
    	sb zero (t0)	# Запись нуля в конец текста
    	mv a0 s3
    	marks_count(a0)
    	j end_read_from_file
	er_name:
    	la a0 er_name_mes
    	li a7 4
    	ecall
    	li a0 -1
    	j end_read_from_file
	er_read:
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