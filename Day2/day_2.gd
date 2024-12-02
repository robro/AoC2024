extends Node2D

var input_path : String = "res://Day2/input.txt"
# var input_path : String = "res://Day2/test.txt"


func _ready() -> void:
	print("Day 2")
	part_one()


func part_one() -> void:
	var reports := get_reports()
	var last_diff := 0
	var curr_diff := 0
	var is_safe := false
	var total_safe := 0

	for report in reports:
		is_safe = true
		last_diff = 0
		for i in report.size():
			if i == 0:
				continue
			curr_diff = report[i] - report[i - 1]
			if curr_diff == 0:
				is_safe = false
				break
			if curr_diff < 0 and last_diff > 0:
				is_safe = false
				break
			if curr_diff > 0 and last_diff < 0:
				is_safe = false
				break
			if abs(curr_diff) > 3:
				is_safe = false
				break
			last_diff = curr_diff

		if is_safe:
			total_safe += 1

	print("Total safe: ", total_safe)


func get_reports() -> Array[Array]:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var report : PackedStringArray
	var levels : Array[int]
	var reports : Array[Array]

	while !input_file.eof_reached():
		report = input_file.get_line().split(" ", false)
		if report.size() == 0:
			continue
		levels = []
		for level in report:
			levels.append(int(level))
		reports.append(levels)

	return reports
