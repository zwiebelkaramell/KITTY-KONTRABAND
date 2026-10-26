extends Node2D




func _on_volume_drag_ended(value_changed: bool) -> void:
	$title/Number.text = str($Volume.value*100) + "%"
	AudioServer.set_bus_volume_linear(AudioServer.get_bus_index("Master"), $Volume.value)
	$Example.play()
	pass # Replace with function body.


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu.tscn")
	pass # Replace with function body.


func _on_texture_button_toggled(toggled_on: bool) -> void:
	if G.Tutorial == true:
		G.Tutorial = false
	else:
		G.Tutorial = true
	pass # Replace with function body.
