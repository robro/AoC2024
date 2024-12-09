extends Node2D

var input_path := "res://Day9/input.txt"
# var input_path := "res://Day9/test.txt"
# var input_path := "res://Day9/test2.txt"


func _ready() -> void:
	print("Day 9")
	part_one()
	part_two()


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


func part_two() -> void:
	var disk_map := FileAccess.open(input_path, FileAccess.READ).get_line()
	var disk_blocks := get_disk_blocks(disk_map)
	var space_ptr := 0
	var file_ptr := disk_blocks.size() - 1
	var file_id : Variant = disk_blocks[file_ptr]
	var file_size := 0
	var space_size := 0
	var temp_value : Variant
	var checksum := 0
	var contiguous_file_blocks := 0

	while not file_id is int:
		file_ptr -= 1
		file_id = disk_blocks[file_ptr]

	while file_id > 0:
		while not disk_blocks[file_ptr] is int or disk_blocks[file_ptr] != file_id:
			file_ptr -= 1

		file_size = 1
		while disk_blocks[file_ptr-1] is int and disk_blocks[file_ptr-1] == file_id:
			file_ptr -= 1
			file_size += 1

		space_ptr = contiguous_file_blocks
		while disk_blocks[space_ptr] is int and space_ptr < disk_blocks.size() - 1:
			space_ptr += 1
		contiguous_file_blocks = space_ptr

		space_size = 0
		while space_size < file_size:
			while disk_blocks[space_ptr] is int and space_ptr < file_ptr:
				space_ptr += 1

			if space_ptr >= file_ptr:
				break

			space_size = 0
			while disk_blocks[space_ptr] is String:
				space_ptr += 1
				space_size += 1

		if space_size >= file_size:
			for i in file_size:
				temp_value = disk_blocks[file_ptr + i]
				disk_blocks[file_ptr + i] = disk_blocks[space_ptr - space_size + i]
				disk_blocks[space_ptr - space_size + i] = temp_value

		file_id -= 1

	for i in disk_blocks.size():
		if not disk_blocks[i] is int:
			continue
		checksum += disk_blocks[i] * i

	print("Part Two: ", checksum)


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
