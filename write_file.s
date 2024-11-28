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
    	li s1 -1			# Проверка на корректное открытие
    	beq a0 s1 er_name	# Ошибка открытия файла
    	mv s1 a0       	# Сохранение дескриптора файла
    	li   a7, 64       		# Системный вызов для записи в файл
    	mv   a0, s1 			# Дескриптор файла
    	mv   a1, s0  			# Адрес буфера записываемого текста
    	li   a2, TEXT_SIZE    			# Размер записываемой порции из регистра
    	ecall             		# Запись в файл
    	close(s1)
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