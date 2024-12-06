class_name Guard
extends Node2D

var obstacles : Array[Vector2]
var facing_index := 0
var facing_directions : Array[Vector2] = [
    Vector2.UP,
    Vector2.RIGHT,
    Vector2.DOWN,
    Vector2.LEFT,
]


func move() -> void:
    var new_position := position + facing_directions[facing_index]

    if new_position in obstacles:
        turn()
        return

    position = new_position


func turn() -> void:
    facing_index += 1
    facing_index %= facing_directions.size()
