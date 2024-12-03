extends Node2D

var input_path := "res://Day3/input.txt"
# var input_path := "res://Day3/test.txt"
var regex := RegEx.new()


func _ready() -> void:
	print("Day 3")
	part_one()


func part_one() -> void:
	regex.compile(r"mul\((\d+),(\d+)\)")
	var input_file := FileAccess.open(input_path, FileAccess.READ)
	var input_str := input_file.get_as_text()
	var matches := regex.search_all(input_str)
	var muls := matches.map(mul_match)
	var results : int = muls.reduce(sum_with_accum)

	print("Results: ", results)


func sum_with_accum(accum: int, num: int) -> int:
	return accum + num


func mul_match(match: RegExMatch) -> int:
	return int(match.get_string(1)) * int(match.get_string(2))
