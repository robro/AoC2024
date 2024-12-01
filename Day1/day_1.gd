extends Node2D

@onready var input_path : String = "res://Day1/input.txt"

func _ready() -> void:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	part_one(input_file)


func part_one(input_file: FileAccess) -> void:
	var list_left : Array[int]
	var list_right : Array[int]
	var line_string : String
	var nums : PackedStringArray
	var total_distance : int = 0

	while !input_file.eof_reached():
		line_string = input_file.get_line()
		if !line_string.is_empty():
			nums = line_string.split(" ", false)
			list_left.append(int(nums[0]))
			list_right.append(int(nums[1]))

	list_left.sort()
	list_right.sort()

	for i in list_left.size():
		total_distance += abs(list_left[i] - list_right[i])

	print("Total distance: ", total_distance)
