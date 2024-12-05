extends Node2D

var input_path := "res://Day5/input.txt"
# var input_path := "res://Day5/test.txt"
@onready var rules := get_rules()
@onready var updates := get_updates()


func _ready() -> void:
	print("Day 5")
	part_one()


func part_one() -> void:
	var left_num_index := -1
	var right_num_index := -1
	var is_correct : bool
	var result := 0

	for update in updates:
		is_correct = true

		for rule in rules:
			left_num_index = update.find(rule[0])
			right_num_index = update.find(rule[1])

			if left_num_index == -1 or right_num_index == -1:
				continue
			if left_num_index > right_num_index:
				is_correct = false
				break

		if is_correct:
			@warning_ignore("integer_division")
			result += update[update.size() / 2]

	print("Part One: ", result)


func get_rules() -> Array[Array]:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var curr_line : String
	var rule : Array
	var _rules : Array[Array]

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			break
		rule = Array(curr_line.split("|")).map(func(x: String) -> int: return int(x))
		_rules.append(rule)

	return _rules


func get_updates() -> Array[Array]:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var curr_line : String
	var update_lines := false
	var update : Array
	var _updates : Array[Array]

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			if !update_lines:
				update_lines = true
			continue
		if !update_lines:
			continue
		update = Array(curr_line.split(",")).map(func(x: String) -> int: return int(x))
		_updates.append(update)

	return _updates
