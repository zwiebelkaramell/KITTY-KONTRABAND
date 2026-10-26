extends Node2D


func _on_button_pressed() -> void:
	G.reset()
	if G.Tutorial:
		get_tree().change_scene_to_file("res://Assets/Scenes/Tutorial.tscn")
	else:
		get_tree().change_scene_to_file("res://Assets/Scenes/Main.tscn")
	pass


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Settings.tscn")
	pass # Replace with function body.
