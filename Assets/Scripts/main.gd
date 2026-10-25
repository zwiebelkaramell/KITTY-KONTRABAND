extends Node2D
var box_scene = preload("res://Assets/Scenes/Instances/Box.tscn")
var xray_scene = preload("res://Assets/Scenes/Instances/Xray.tscn")

var obj_list = load("res://Assets/Scripts/Object scripts/ObjectList.gd").new()

func _process(delta: float) -> void:
	$Boxes.position.x += (G.Speed*delta)
	for n in $Boxes.get_child_count(): #sigh
		if $Boxes.get_child(n).global_position.x > 1500 && $Boxes.get_child(n).name != "BackBufferCopy": #sigh
			$Boxes.get_child(n).queue_free()
			print("See ya, clowno!")
	for n in $Boxes/BackBufferCopy.get_child_count():
		if $Boxes/BackBufferCopy.get_child(n).global_position.x > 1500:
			$Boxes/BackBufferCopy.get_child(n).queue_free()
			if $Boxes/BackBufferCopy.get_child(n).cont_obj.is_cat:
				G.ResFails += 1
			else:
				G.Quota -= 1
			print("See ya, bozo!")
	if G.ResFails >= G.fail_num:
		get_tree().change_scene_to_file("res://Assets/Scenes/Fail.tscn")
	elif G.Quota >= 0:
		get_tree().change_scene_to_file("res://Assets/Scenes/Inbetween.tscn")
	
	pass

func _ready() -> void:
	day_start()
	do_box()
	$Sound/BGS_60hzHumLoop.play()
	$Sound/SFX_ConveyorStart.play()
	
	pass

func do_box():
	var box = box_scene.instantiate()
	var xray = xray_scene.instantiate()
	box.position = $Marker_Spawn.position - $Boxes.position
	xray.position = $Marker_Spawn.position - $Boxes.position
	xray.pass_obj(G.PKGList[0])
	xray.get_child(0).set_texture(load(xray.cont_obj.path))
	G.PKGList.pop_at(0)
	$Boxes/BackBufferCopy.add_child(box)
	$Boxes.add_child(xray)
	$Timers/BoxSpawn.start()
	pass

func day_start(): #pull data on magic objects, replace some with cats
	var package_num = G.Quota + G.CatNum + G.fail_num + 6 #how many packages to distribute
	for n in range(0, package_num):
		var x = randi_range(0, (len(obj_list.non_cat)-1)) #randi_range is inclusive for some reason
		G.PKGList.append(obj_list.non_cat[x])
	for n in range(0, G.CatNum):
		var x = randi_range(0, len(G.PKGList)-1)
		var y = randi_range(0, (len(obj_list.cat)-1))
		G.PKGList[x] = obj_list.cat[y]
		print("CAT ACTIVATED")
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
