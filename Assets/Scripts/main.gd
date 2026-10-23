extends Node2D
var box_scene = preload("res://Assets/Scenes/Instances/Box.tscn")
@onready var boxes = $Boxes


func _process(delta: float) -> void:
	boxes.position.x += (G.Speed*delta)
	
	pass

func _ready() -> void:
	$Conveyor.play()
	do_box()
	$Sound/BGM.play()
	
	pass

func do_box():
	var box = box_scene.instantiate()
	box.position = $Marker_Spawn.position
	boxes.add_child(box)
	pass
