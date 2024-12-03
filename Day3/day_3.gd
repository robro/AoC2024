extends Node2D

var input_path := "res://Day3/input.txt"
# var input_path := "res://Day3/test.txt"
# var input_path := "res://Day3/test2.txt"
var regex := RegEx.new()
var regex_str := r"mul\((\d+),(\d+)\)"
@onready var input_str := FileAccess.open(input_path, FileAccess.READ).get_as_text().replace("\n", "")


func _ready() -> void:
	print("Day 3")
	part_one()
	part_two()


func part_one() -> void:
	print("Part One: ", get_results(input_str))


func part_two() -> void:
	regex.compile(r"don't\(\).*?(?=do\(\)|$)")
	var sub_str := regex.sub(input_str, "", true)

	print("Part Two: ", get_results(sub_str))


func get_results(search_str: String) -> int:
	regex.compile(regex_str)
	return regex.search_all(search_str).map(mul_match).reduce(sum_with_accum)


func sum_with_accum(accum: int, num: int) -> int:
	return accum + num


func mul_match(match: RegExMatch) -> int:
	return int(match.get_string(1)) * int(match.get_string(2))
