extends Node2D

var input_path := "res://Day6/input.txt"
# var input_path := "res://Day6/test.txt"
var start_position : Vector2
var obstacles : Array[Vector2]
var guard : Guard
var area : Rect2


func _ready() -> void:
	setup_area()
	print("Day 6")
	part_one()
	part_two()


func part_one() -> void:
	var distinct_positions := get_distinct_positions()

	print("Part One: ", distinct_positions.size())


func part_two() -> void:
	var distinct_positions := get_distinct_positions()
	var test_obstacles : Array[Vector2]
	var total_obstructions := 0

	for test_position in distinct_positions:
		if test_position == start_position:
			continue
		test_obstacles = obstacles.duplicate()
		test_obstacles.append(test_position)
		guard = Guard.new(start_position, test_obstacles)

		while area.has_point(guard.position):
			if !guard.move():
				total_obstructions += 1
				break

	print("Part Two: ", total_obstructions)


func get_distinct_positions() -> Dictionary:
	var distinct_positions : Dictionary
	guard = Guard.new(start_position, obstacles)

	while area.has_point(guard.position):
		distinct_positions[guard.position] = true
		guard.move()

	return distinct_positions


func setup_area() -> void:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var curr_line : String
	var y := 0

	while !input_file.eof_reached():
		curr_line = input_file.get_line()

		if curr_line == "":
			continue

		if curr_line.length() > area.size.x:
			area.size.x = curr_line.length()

		for x in curr_line.length():
			if curr_line[x] == "#":
				obstacles.append(Vector2(x, y))
			elif curr_line[x] == "^":
				start_position = Vector2(x, y)

		y += 1

	area.size.y = y
