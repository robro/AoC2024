extends Node2D

var input_path := "res://Day10/input.txt"
# var input_path := "res://Day10/test.txt"
var map := get_map()


func _ready() -> void:
	print("Day 10")
	part_one()
	part_two()


func part_one() -> void:
	var score_sum := 0

	for y in map.size():
		for x in map[y].size():
			if map[y][x] == 0:
				score_sum += get_score(Vector2(x, y))

	print("Part One: ", score_sum)


func part_two() -> void:
	var score_sum := 0

	for y in map.size():
		for x in map[y].size():
			if map[y][x] == 0:
				score_sum += get_score(Vector2(x, y), true)

	print("Part Two: ", score_sum)


func get_score(start_pos: Vector2, use_rating: bool = false) -> int:
	var end_points : Dictionary
	var queue := [start_pos]
	var curr_height : int
	var curr_pos : Vector2
	var next_pos : Vector2
	var rating := 0
	const directions := [
		Vector2.UP,
		Vector2.RIGHT,
		Vector2.DOWN,
		Vector2.LEFT,
	]

	while !queue.is_empty():
		curr_pos = queue.pop_back()
		curr_height = map[curr_pos.y][curr_pos.x]
		if curr_height == 9:
			end_points[curr_pos] = true
			rating += 1
			continue
		for direction in directions:
			next_pos = curr_pos + direction
			if next_pos.x < 0 or next_pos.y < 0:
				continue
			if next_pos.x >= map[0].size() or next_pos.y >= map.size():
				continue
			if map[next_pos.y][next_pos.x] != curr_height + 1:
				continue
			queue.append(next_pos)

	if use_rating:
		return rating
	return end_points.size()


func get_map() -> Array[Array]:
	var input_file = FileAccess.open(input_path, FileAccess.READ)
	var curr_line : String
	var _map : Array[Array]

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			continue
		_map.append(Array(curr_line.split("")).map(func(x: String) -> int: return int(x)))

	return _map
