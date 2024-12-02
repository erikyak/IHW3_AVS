.data 
marks: .asciz ",.:;\"\'-()?!"
marks_number: .space 4096
.global marks_count
.include "macrolib.s"
.text 
marks_count:
	push(ra)
	push(s0)
	mv s0 a0
	la a0 marks
	la t3 marks_number
	mark_count_loop:
		lb t1 (a0)
		beqz t1 mark_count_end
		mark_equal(t3 t1)
		li t4 0
		mv t5 s0
		text_loop:
			lb t2 (t5)
			beqz t2 text_end
			bne t1 t2 not_plus_num
			plus1(t4)
			not_plus_num:
			plus1(t5)
			j text_loop
		text_end:
		plus1(a0)
		save_mark(t3 t4)
		li t4 '\n'
		sb t4 (t3)
		plus1(t3)
		j mark_count_loop
	mark_count_end:
	li t4 0
	sb t4 (t3)
	pop(s0)
	pop(ra)
	la a0 marks_number
	ret