extends Node2D

var input_path := "res://Day5/input.txt"
# var input_path := "res://Day5/test.txt"
var rules : Array
var updates : Array


func _ready() -> void:
	set_rules_and_updates()
	print("Day 5")
	part_one()
	part_two()


func part_one() -> void:
	print("Part One: ", get_result(true))


func part_two() -> void:
	print("Part Two: ", get_result(false))


func get_result(correct: bool) -> int:
	var result := 0
	var updates_copy = updates.duplicate(true)

	for update in updates_copy:
		if correct_update(update) == correct:
			@warning_ignore("integer_division")
			result += update[update.size() / 2]

	return result


func correct_update(update: Array) -> bool:
	var left_num_index := -1
	var right_num_index := -1
	var is_correct := false
	var was_correct := true

	while !is_correct:
		is_correct = true

		for rule in rules:
			left_num_index = update.find(rule[0])
			right_num_index = update.find(rule[1])

			if left_num_index == -1 or right_num_index == -1:
				continue
			if left_num_index > right_num_index:
				update.insert(left_num_index, update.pop_at(right_num_index))
				is_correct = false
				was_correct = false
				break

	return was_correct


func set_rules_and_updates() -> void:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var curr_line : String
	var is_update_line := false

	rules.clear()
	updates.clear()

	while !input_file.eof_reached():
		curr_line = input_file.get_line()
		if curr_line == "":
			if !is_update_line:
				is_update_line = true
			continue
		if !is_update_line:
			rules.append(Array(curr_line.split("|")).map(func(x: String) -> int: return int(x)))
		else:
			updates.append(Array(curr_line.split(",")).map(func(x: String) -> int: return int(x)))
