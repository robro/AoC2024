extends Node2D

var input_path : String = "res://Day2/input.txt"
# var input_path : String = "res://Day2/test.txt"


func _ready() -> void:
	print("Day 2")
	part_one()
	part_two()


func part_one() -> void:
	var reports := get_reports()
	var safe_reports = reports.filter(report_safety)

	print("Total safe: ", safe_reports.size())


func part_two() -> void:
	var reports := get_reports()
	var safe_reports = reports.filter(perms_safety)

	print("Total safe: ", safe_reports.size())


func report_safety(report: Array[int]) -> bool:
	var last_diff := 0
	var curr_diff := 0

	for i in report.size():
		if i == 0:
			continue
		curr_diff = report[i] - report[i - 1]
		if curr_diff == 0:
			return false
		if curr_diff < 0 and last_diff > 0:
			return false
		if curr_diff > 0 and last_diff < 0:
			return false
		if abs(curr_diff) > 3:
			return false
		last_diff = curr_diff

	return true


func perms_safety(report: Array[int]) -> bool:
	var report_perm : Array[int]

	for i in report.size():
		report_perm = report.duplicate()
		report_perm.remove_at(i)

		if report_safety(report_perm):
			return true

	return false


func get_reports() -> Array[Array]:
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var report : PackedStringArray
	var reports : Array[Array]
	var levels : Array[int]

	while !input_file.eof_reached():
		report = input_file.get_line().split(" ", false)
		if report.size() == 0:
			continue
		levels = []
		for level in report:
			levels.append(int(level))
		reports.append(levels)

	return reports
