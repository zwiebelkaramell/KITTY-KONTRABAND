extends Node2D
@onready var txt = $UI/Container/Label

func _ready() -> void:
	
	match G.ResFails:
		0:
			txt.text = "SUCCESS!\n OUR GLORIOUS NATION IS SAFE THANKS TO YOU COMRADE!"
		1:
			txt.text = "SUCCESS!\n YOU HAVE FAILED LESS THAN WE EXPECTED OF YOU COMRADE! KEEP IT UP!"
		2:
			txt.text = "SUCCESS!\n AN ACCEPTABLE AMOUNT OF CONTRABAND HAS ENTERED OUR COUNTRY."
	
	pass


func _on_button_pressed() -> void:
	# add logic for increasing difficulty here
	get_tree().change_scene_to_file("res://Assets/Scenes/Main.tscn")
	pass # Replace with function body.
