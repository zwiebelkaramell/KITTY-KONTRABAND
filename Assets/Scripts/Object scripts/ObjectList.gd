extends Node

var content = load("res://Assets/Scripts/Object scripts/Contents.gd")

func add_data(is_cat: bool, difficulty: int, path: String):
	var c = content.new()
	c.is_cat = is_cat
	c.difficulty = difficulty
	c.path = path
	return c

@export var non_cat = [
	add_data(false, 0, "res://Assets/Art/objects n cats/blue orb.png"),
	add_data(false, 0, "res://Assets/Art/objects n cats/books.png"),
	add_data(false, 0, "res://Assets/Art/objects n cats/broken broom.png"),
	add_data(false, 0, "res://Assets/Art/objects n cats/potion.png"),
	add_data(false, 0, "res://Assets/Art/objects n cats/scroll.png"),
	add_data(false, 1, "res://Assets/Art/objects n cats/skull.png"),
	add_data(false, 1, "res://Assets/Art/objects n cats/grgoil.png"),
]

@export var cat = [
	add_data(true, 0, "res://Assets/Art/objects n cats/black cat.png"),
	add_data(true, 0, "res://Assets/Art/objects n cats/gray cat.png"),
	add_data(true, 0, "res://Assets/Art/objects n cats/my dead best friend cat 3.png"),
	add_data(true, 0, "res://Assets/Art/objects n cats/ortange vcat.png"),
	add_data(true, 0, "res://Assets/Art/objects n cats/whoite cat 4.png"),
	add_data(true, 1, "res://Assets/Art/objects n cats/gartgiol cat.png"),
	add_data(true, 1, "res://Assets/Art/objects n cats/cat skull.png"),
]
