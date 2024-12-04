extends Node2D

var input_path := "res://Day4/input.txt"
# var input_path := "res://Day4/test.txt"
@onready var input_lines := get_input_lines()


func _ready() -> void:
	print("Day 4")
	part_one()


func part_one() -> void:
	var result := 0

	for y in input_lines.size():
		for x in input_lines[0].length():
			result += xmas_count(x, y)

	print("Part One: ", result)


func xmas_count(x: int, y: int) -> int:
	if input_lines[y][x] != "X":
		return 0

	var count := 0
	var xmas_index : int
	var curr_pos : Vector2i
	var curr_char : String
	var directions := [
		Vector2i(1, 0),
		Vector2i(1, 1),
		Vector2i(0, 1),
		Vector2i(-1, 1),
		Vector2i(-1, 0),
		Vector2i(-1, -1),
		Vector2i(0, -1),
		Vector2i(1, -1),
	]

	for direction in directions:
		xmas_index = 0
		curr_pos = Vector2i(x, y)

		while xmas_index < 4:
			if curr_pos.x < 0 or curr_pos.y < 0:
				break
			if curr_pos.x >= input_lines[0].length() or curr_pos.y >= input_lines.size():
				break
			curr_char = input_lines[curr_pos.y][curr_pos.x]

			if curr_char != "XMAS"[xmas_index]:
				break
			if curr_char == "S":
				count += 1
				break
			curr_pos += direction
			xmas_index += 1

	return count


func get_input_lines() -> Array[String]:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var input_line : String
	var _input_lines : Array[String]

	while !input_file.eof_reached():
		input_line = input_file.get_line()
		if input_line == "":
			continue
		_input_lines.append(input_line)

	return _input_lines