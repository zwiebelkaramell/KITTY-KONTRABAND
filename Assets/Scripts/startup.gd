extends Node2D

func _ready() -> void:
	#in case we need to do stuff before the game happens
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu.tscn")
	
	pass
