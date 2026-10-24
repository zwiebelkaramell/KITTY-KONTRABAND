extends Node

var content = load("res://Assets/Scripts/Object scripts/Contents.gd")

func add_data(is_cat: bool, difficulty: int, path: String):
	var c = content.new()
	c.is_cat = is_cat
	c.difficulty = difficulty
	c.path = path
	return c

@export var non_cat = [
	add_data(false, 0, "res://Assets/Art/temp_xray.png")
]

@export var cat = [
	add_data(true, 0, "res://Assets/Art/temp_cat.png")
]
