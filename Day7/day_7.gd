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
	var nums : PackedFloat64Array
	var perms : Array[Array]
	var sep_index := -1

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			continue
		sep_index = curr_line.find(":")
		test_value = int(curr_line.substr(0, sep_index))
		nums = curr_line.substr(sep_index + 1).split_floats(" ", false)
		perms = get_permutations(operators, nums.size() - 1)

		for perm in perms:
			if true_equation(nums, perm, test_value):
				result += test_value
				break

	return result


func true_equation(nums: PackedFloat64Array, perm: Array, test_value: int) -> bool:
	var left_num := 0.
	var right_num := 0.

	left_num = nums[0]
	for i in nums.size() - 1:
		right_num = nums[i + 1]
		left_num = call(perm[i], left_num, right_num)

	if left_num == test_value:
		return true

	return false


func get_permutations(items: Array, length: int) -> Array[Array]:
	var perms : Array[Array]
	var queue : Array[Array]
	var curr_perm : Array
	var new_perm : Array

	for item in items:
		queue.append([item])

	while !queue.is_empty():
		curr_perm = queue.pop_back()
		if curr_perm.size() == length:
			perms.append(curr_perm)
			continue
		for item in items:
			new_perm = curr_perm.duplicate()
			new_perm.append(item)
			queue.append(new_perm)

	return perms


func add(a: float, b: float) -> float:
	return a + b


func mul(a: float, b: float) -> float:
	return a * b


func concat(a: float, b: float) -> float:
	return float(str(a) + str(b))
