extends Node2D

var input_path := "res://Day12/input.txt"
# var input_path := "res://Day12/test.txt"
var garden := get_garden()
var visited : Dictionary


func _ready() -> void:
	print("Day 12")
	part_one()


func part_one() -> void:
	var curr_pos : Vector2
	var curr_crop : Array[int]
	var sum_price := 0

	visited.clear()

	for y in garden.size():
		for x in garden[y].size():
			curr_pos = Vector2(x, y)
			if !visited.has(curr_pos):
				curr_crop = get_contiguous_crop(curr_pos)
				sum_price += curr_crop[0] * curr_crop[1]
				# print(garden[y][x], " ", curr_crop)

	print("Part One: ", sum_price)


func get_contiguous_crop(pos: Vector2) -> Array[int]:
	var crop : Array[int] = [0, 0]
	var queue := [pos]
	var curr_pos : Vector2
	var test_pos : Vector2
	const offsets := [
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN,
		Vector2.LEFT,
	]

	while !queue.is_empty():
		curr_pos = queue.pop_front()
		if visited.has(curr_pos):
			continue
		visited[curr_pos] = true
		crop[0] += 1
		crop[1] += get_perimeter_value(curr_pos)

		for offset in offsets:
			test_pos = curr_pos + offset
			if visited.has(test_pos):
				continue
			if test_pos.x < 0 or test_pos.y < 0:
				continue
			if test_pos.x >= garden[0].size() or test_pos.y >= garden.size():
				continue
			if garden[test_pos.y][test_pos.x] != garden[pos.y][pos.x]:
				continue
			queue.append(test_pos)

	return crop


func get_perimeter_value(pos: Vector2) -> int:
	var perimeter_value := 0
	var test_pos : Vector2
	const offsets := [
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN,
		Vector2.LEFT,
	]

	for offset in offsets:
		test_pos = pos + offset
		if test_pos.x < 0 or test_pos.y < 0:
			perimeter_value += 1
		elif test_pos.x >= garden[0].size() or test_pos.y >= garden.size():
			perimeter_value += 1
		elif garden[test_pos.y][test_pos.x] != garden[pos.y][pos.x]:
			perimeter_value += 1

	return perimeter_value


func get_garden() -> Array[Array]:
	var _garden : Array[Array]
	var curr_line : String
	var input_file := FileAccess.open(input_path, FileAccess.READ)

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			continue
		_garden.append(Array(curr_line.split("")))

	return _garden
