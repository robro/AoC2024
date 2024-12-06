class_name Guard
extends Node2D

var obstacles : Array[Vector2]
var history : Dictionary
var facing_index := 0
var facing_directions : Array[Vector2] = [
    Vector2.UP,
    Vector2.RIGHT,
    Vector2.DOWN,
    Vector2.LEFT,
]
var facing : Vector2:
    get:
        return facing_directions[facing_index]


func _init(start_position: Vector2, _obstacles: Array[Vector2]):
    position = start_position
    obstacles = _obstacles
    history[position] = [facing]


func move() -> bool:
    var new_position := position + facing

    if new_position in obstacles:
        turn()
        return true

    position = new_position

    if history.has(position):
        if facing in history.get(position):
            return false
        history[position].append(facing)
    else:
        history[position] = [facing]

    return true


func turn() -> void:
    facing_index += 1
    facing_index %= facing_directions.size()
