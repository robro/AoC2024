extends Node2D

var input_path := "res://Day9/input.txt"
# var input_path := "res://Day9/test.txt"


func _ready() -> void:
	print("Day 9")
	part_one()


func part_one() -> void:
	var disk_map := FileAccess.open(input_path, FileAccess.READ).get_line()
	var disk_blocks := get_disk_blocks(disk_map)
	var left_ptr := 0
	var right_ptr := disk_blocks.size() - 1
	var temp_value : Variant
	var checksum := 0

	while left_ptr < right_ptr:
		while disk_blocks[left_ptr] is int and left_ptr < right_ptr:
			left_ptr += 1
		while disk_blocks[right_ptr] is String and left_ptr < right_ptr:
			right_ptr -= 1
		if left_ptr >= right_ptr:
			break

		temp_value = disk_blocks[left_ptr]
		disk_blocks[left_ptr] = disk_blocks[right_ptr]
		disk_blocks[right_ptr] = temp_value

	for i in disk_blocks.size():
		if disk_blocks[i] is String:
			break
		checksum += disk_blocks[i] * i

	print("Part One: ", checksum)


func get_disk_blocks(disk_map: String) -> Array:
	var disk_blocks := []
	var curr_blocks := []
	var file_id := 0

	for i in disk_map.length():
		curr_blocks.resize(int(disk_map[i]))
		if i % 2 == 0:
			curr_blocks.fill(file_id)
			file_id += 1
		else:
			curr_blocks.fill(".")
		disk_blocks.append_array(curr_blocks)

	return disk_blocks
