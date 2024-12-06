extends Node2D

var input_path := "res://Day6/input.txt"
# var input_path := "res://Day6/test.txt"
var guard := Guard.new()
var area : Rect2


func _ready() -> void:
	setup_area()
	print("Day 6")
	part_one()


func part_one() -> void:
	var distinct_positions : Dictionary

	while area.has_point(guard.position):
		distinct_positions[guard.position] = true
		guard.move()

	print("Part One: ", distinct_positions.size())


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
				guard.obstacles.append(Vector2(x, y))
			elif curr_line[x] == "^":
				guard.position = Vector2(x, y)

		y += 1

	area.size.y = y
