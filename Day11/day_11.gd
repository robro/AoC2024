extends Node2D

var input_path := "res://Day11/input.txt"
# var input_path := "res://Day11/test.txt"
var input_str := FileAccess.open(input_path, FileAccess.READ).get_line()
var input_list := Array(input_str.split(" ")).map(func(x: String) -> int: return int(x))


func _ready() -> void:
	print("Day 11")
	part_one()


func part_one() -> void:
	print("Part One: ", get_stone_count(25))


func get_stone_count(blinks: int) -> int:
	var stone_list := input_list.duplicate(true)
	var new_list : Array
	var curr_stone : int
	var stone_str : String

	while blinks > 0:
		new_list.clear()

		for i in stone_list.size():
			curr_stone = stone_list[i]
			stone_str = str(curr_stone)

			if curr_stone == 0:
				new_list.append(1)
			elif stone_str.length() % 2 == 0:
				@warning_ignore("integer_division")
				new_list.append(int(stone_str.substr(0, stone_str.length() / 2)))
				@warning_ignore("integer_division")
				new_list.append(int(stone_str.substr(stone_str.length() / 2)))
			else:
				new_list.append(curr_stone * 2024)

		stone_list = new_list.duplicate(true)
		blinks -= 1

	return stone_list.size()
