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


func _on_x_ray_toggled(toggled_on: bool) -> void:
	for x in boxes.get_child_count():
		boxes.get_child(x).toggle_xray()
	if toggled_on:
		G.IsXray = true
	else:
		G.IsXray = false

func sound_update():
	for x in $Sound.get_child_count():
		var sound = $Sound.get_child(x)
		if sound.music:
			sound.volume_linear == (G.VolMaster*G.VolMusic)
		elif sound.sfx:
			sound.volume_linear == (G.VolMaster*G.VolSFX)
	pass
