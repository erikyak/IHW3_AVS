.include "macrolib.s"
.global tests
.text

tests:
	push(ra)
	run_test("data/nothing.txt", "output/test_nothing.txt")
	run_test("data/fox.txt", "output/test_fox.txt")
	run_test("data/fox_commas.txt", "output/test_fox_commas.txt")
	run_test("data/test_output.txt", "output/test_test_output.txt")
	run_test("data/commas.txt", "output/test_commas.txt")
	run_test("data/a_lot_of_marks.txt", "output/test_a_lot_of_marks.txt")
	run_test("data/ViM.txt", "output/test_ViM.txt")			# This might turn long, because of its size(10559 symbols)
	pop(ra)
	ret