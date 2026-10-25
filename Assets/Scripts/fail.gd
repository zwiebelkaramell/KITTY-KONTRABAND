extends Node2D


func _ready() -> void:
	if G.ResFailNonCat:
		$VBoxContainer/Label.text = "YOU HAVE FAILED US COMRADE!\nHOW WILL OUR CITIZENS GET THEIR MAIL IF YOU CONFISCATE ALL OF IT!"
	else:
		$VBoxContainer/Label.text = "YOU HAVE FAILED US COMRADE!\nHEXES AND SPELLS WILL RUN RAMPANT IN THE COUNTRYSIDE!"

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/Scenes/Menu.tscn")
	pass # Replace with function body.
