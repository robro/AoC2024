extends Node2D

var input_path := "res://Day7/input.txt"
# var input_path := "res://Day7/test.txt"


func _ready() -> void:
	print("Day 7")
	part_one()
	part_two()


func part_one() -> void:
	const operators : Array[String] = [
		"add",
		"mul",
	]

	print("Part One: ", total_calibration(operators))


func part_two() -> void:
	const operators : Array[String] = [
		"add",
		"mul",
		"concat",
	]

	print("Part Two: ", total_calibration(operators))


func total_calibration(operators: Array[String]) -> int:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var curr_line : String
	var result := 0
	var test_value := 0
	var nums : Array
	var sep_index := -1

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			continue
		sep_index = curr_line.find(":")
		test_value = int(curr_line.substr(0, sep_index))
		nums = Array(curr_line.substr(sep_index + 1).split_floats(" ", false))

		if true_equation(operators, test_value, nums[0], nums.slice(1), 0, nums.size() - 1):
			result += test_value

	return result


func true_equation(
	operations: Array[String],
	test_value: int,
	curr_value: int,
	nums: Array,
	index: int,
	length: int
) -> bool:
	if index == length:
		return curr_value == test_value
	for op in operations:
		if true_equation(
			operations,
			test_value,
			call(op, curr_value, nums[index]),
			nums,
			index + 1,
			length
		) == true:
			return true

	return false


func add(a: float, b: float) -> float:
	return a + b


func mul(a: float, b: float) -> float:
	return a * b


func concat(a: float, b: float) -> float:
	return float(str(a) + str(b))
