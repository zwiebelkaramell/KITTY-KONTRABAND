extends Node2D
var box_scene = preload("res://Assets/Scenes/Instances/Box.tscn")
var xray_scene = preload("res://Assets/Scenes/Instances/xray.tscn")

func _process(delta: float) -> void:
	$Boxes.position.x += (G.Speed*delta)
	pass

func _ready() -> void:
	$Conveyor.play()
	day_start()
	do_box()
	$Sound/BGM.play()
	
	pass

func do_box():
	var box = box_scene.instantiate()
	var xray = xray_scene.instantiate()
	box.position = $Marker_Spawn.position - $Boxes.position
	xray.position = $Marker_Spawn.position - $Boxes.position
	$Boxes/BackBufferCopy.add_child(box)
	$Boxes.add_child(xray)
	$Timers/BoxSpawn.start()
	pass
	
func day_start(): #pull data on magic objects, replace some with cats
	pass
	
func sound_update():
	for x in $Sound.get_child_count():
		var sound = $Sound.get_child(x)
		if sound.music:
			sound.volume_linear = (G.VolMaster*G.VolMusic)
		elif sound.sfx:
			sound.volume_linear = (G.VolMaster*G.VolSFX)
	pass

func _on_x_ray_toggled(toggled_on: bool) -> void:
	$Boxes.toggle_xray()
	if toggled_on:
		G.IsXray = true
	else:
		G.IsXray = false

func _on_box_spawn_timeout() -> void:
	do_box()
	pass
