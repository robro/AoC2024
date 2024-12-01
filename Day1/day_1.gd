extends Node2D

var input_path : String = "res://Day1/input.txt"
var left_list : Array[int]
var right_list : Array[int]

func _ready() -> void:
	print("Day 1")
	part_one()
	part_two()


func part_one() -> void:
	var total_distance := 0

	set_lists()
	left_list.sort()
	right_list.sort()

	for i in left_list.size():
		total_distance += abs(left_list[i] - right_list[i])

	print("Total distance: ", total_distance)


func part_two() -> void:
	var similarity_score := 0

	set_lists()

	for num in left_list:
		similarity_score += num * right_list.count(num)

	print("Similarity Score: ", similarity_score)


func set_lists() -> void:
	var line_string : String
	var nums : PackedStringArray
	var input_file := FileAccess.open(input_path, FileAccess.READ)

	left_list.clear()
	right_list.clear()

	while !input_file.eof_reached():
		line_string = input_file.get_line()
		if !line_string.is_empty():
			nums = line_string.split(" ", false)
			left_list.append(int(nums[0]))
			right_list.append(int(nums[1]))
