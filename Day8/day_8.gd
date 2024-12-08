extends Node2D

var input_path := "res://Day8/input.txt"
# var input_path := "res://Day8/test.txt"
var area : Rect2


func _ready() -> void:
	print("Day 8")
	part_one()


func part_one() -> void:
	var antennas = get_antennas()
	var antinodes : Dictionary

	for a_type in antennas.values():
		for pair in get_pairs(a_type):
			add_antinodes(pair, antinodes)

	print("Part One: ", antinodes.size())


func get_pairs(arr: Array) -> Array[Array]:
	var pairs : Array[Array]

	for i in arr.size() - 1:
		for j in range(i + 1, arr.size()):
			pairs.append([arr[i], arr[j]])

	return pairs


func add_antinodes(pair: Array, antinodes: Dictionary) -> void:
	var diff : Vector2 = pair[0] - pair[1]
	var antinode := Vector2.ZERO

	for node in pair:
		for op in ["add", "sub"]:
			antinode = call(op, node, diff)
			if antinode not in pair and area.has_point(antinode):
				antinodes[antinode] = true


func get_antennas() -> Dictionary:
	var input_file = FileAccess.open(input_path, FileAccess.READ)
	var antennas : Dictionary
	var curr_line : String
	var x := 0
	var y := 0

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			continue

		x = 0
		for c in curr_line:
			if c != ".":
				if antennas.has(c):
					antennas[c].append(Vector2(x, y))
				else:
					antennas[c] = [Vector2(x, y)]
			x += 1
			if x > area.size.x:
				area.size.x = x
		y += 1
		if y > area.size.y:
			area.size.y = y

	return antennas


func add(a: Vector2, b: Vector2) -> Vector2:
	return a + b


func sub(a: Vector2, b: Vector2) -> Vector2:
	return a - b
