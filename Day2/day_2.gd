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
	var report_perm : Array[int]
	var report_perms : Array[Array]
	var total_safe := 0

	for report in reports:
		report_perms.clear()
		for i in report.size():
			report_perm = report.duplicate()
			report_perm.remove_at(i)
			report_perms.append(report_perm)

		if report_perms.any(report_safety):
			total_safe += 1

	print("Total safe: ", total_safe)


func report_safety(report: Array) -> bool:
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
