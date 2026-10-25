extends Node2D


func _on_button_pressed() -> void:
	G.reset()
	get_tree().change_scene_to_file("res://Assets/Scenes/Main.tscn")
	pass
