extends Node2D
var box_scene = preload("res://Assets/Scenes/Instances/Box.tscn")
var xray_scene = preload("res://Assets/Scenes/Instances/Xray.tscn")

var obj_list = load("res://Assets/Scripts/Object scripts/ObjectList.gd").new()

var clicked_boxes = []
var tuna_bool = false

var progress = 0

@onready var t = $Control/VBoxContainer/TUTORIAL


func _process(delta: float) -> void:
	
	
	$Boxes.position.x += (G.Speed*delta)
	
	for n in $Boxes.get_child_count(): #sigh
		if $Boxes.get_child(n).global_position.x > 1500 && $Boxes.get_child(n).has_meta("Xray"): #sigh
			if $Boxes.get_child(n).cont_obj.is_cat:
				pass
			else:
				pass
			$Boxes.get_child(n).queue_free()
			print("See ya, clowno!")
	for n in $Boxes/BackBufferCopy.get_child_count():
		if $Boxes/BackBufferCopy.get_child(n).global_position.x > 1500 && $Boxes/BackBufferCopy.get_child(n).name != "Mask":
			$Boxes/BackBufferCopy.get_child(n).queue_free()
			print("See ya, bozo!")
	if G.Quota <= 0:
		get_tree().change_scene_to_file("res://Assets/Scenes/Main.tscn")
	
	pass
	
func tutorial():
	match progress:
		0:
			pass
		1:
			t.text = "GOOD JOB, NOW; HOVER OVER A BOX TO SEE INSIDE"
		2:
			t.text = "AS YOU CAN SEE, THERE IS A CAT IN THIS MAIL!\n
			THE GRAND VISEER HAS FORBIDDEN THIS DUE TO THE RISK OF WITCHCRAFT!\n
			QUICKLY, GRAB A KNIFE"
			$UI/KNIFE.visible = true
		3:
			t.text = "NOW CLICK ON A BOX TO SEND THE CAT BACK FROM WHENCE HE CAME!"
		4:
			t.text = "EXCELLENT! NOW WHOEVER TRIED TO SMUGGLE THAT FELINE WILL HAVE TO THINK AGAIN!\n
			NOW, RETURN TO YOUR DETECTION RAY!"
		5:
			t.text = "CHECK FOR ANY MORE SNEAKY FELINES"
		6:
			t.text = "THERE ARE NO CATS TO BE FOUND, EXCELLENT\n
			WAIT A MINUTE, DO YOU HEAR THAT NOISE? CLICK ON THE HEARING MACHINE, I SMELL A CAT!"
			$UI/Stethoscope.visible = true
		7:
			t.text = "HOLD THE DEVICE UP TO THE BOX, LISTEN FOR ANIMALS"
		8:
			t.text = "THERE IS A HIDDEN CAT! REMOVE IT, QUICKLY!"
		9:
			t.text = "EXCELLENT WORK COMRADE, I TRUST YOU HAVE IT FROM HERE.\n
			REMEMBER, ONLY REMOVE THE CATS, NOT THE MAIL!\n
			RETURN TO YOUR DETECTOR, AND WE WILL SAY YOUR TRAINING IS DONE"
			
			

func _ready() -> void:
	do_box()
	$Sound/BGS_60hzHumLoop.play()
	$Sound/SFX_ConveyorStart.play()
	
	pass

func do_box():
	var box = box_scene.instantiate()
	var xray = xray_scene.instantiate()
	box.position = $Marker_Spawn.position - $Boxes.position
	xray.position = $Marker_Spawn.position - $Boxes.position
	
	if progress < 4:
		xray.pass_obj(obj_list.cat[2])
	elif progress >= 4:
		xray.pass_obj(obj_list.cat[6])
		
	
	xray.get_child(0).set_texture(load(xray.cont_obj.path))
	xray.pressed.connect(_on_box_clicked.bind(xray, box))
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
		var tuna = randi_range(0, 1)
		G.PKGList[x] = obj_list.cat[y]
		G.PKGList[x].is_tuna = bool(tuna)
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

func exclusive_toggle(pressed: String): #toggles off all the other buttons when you chose a different tool
	if pressed != $"UI/X-Ray".name:
		$"UI/X-Ray".button_pressed = false
		_on_x_ray_toggled(false)
	if pressed != $UI/KNIFE.name:
		$UI/KNIFE.button_pressed = false
		_on_knife_toggled(false)
	if pressed != $UI/Stethoscope.name:
		$UI/Stethoscope.button_pressed = false
		_on_stethoscope_toggled(false)
	if pressed != $UI/Tuna.name:
		$UI/Tuna.button_pressed = false
		_on_tuna_toggled(false)
	pass

func _on_box_spawn_timeout() -> void:
	do_box()
	pass
	
func _on_box_clicked(xray: Node, box: Node):
	if progress == 3:
		progress += 1
		tutorial()
	if progress == 8:
		progress += 1
		tutorial()

	if G.IsKnife:
		G.Speed = 0
		$Timers/BeltPause.start()
		box.queue_free()
		xray.get_child(0).set_material(null)
		if xray.cont_obj.is_cat:
			xray.deposit = true
			pass
		else:
			G.ResFails += 1
			if G.ResFails >= G.fail_num:
				G.ResFailNonCat = true
		clicked_boxes.append(xray)
		print(clicked_boxes)
	pass

func _on_belt_pause_timeout() -> void:
	G.Speed = G.base_speed
	for x in range(0, len(clicked_boxes)):
		clicked_boxes[0].queue_free()
		clicked_boxes.pop_at(0)
	if G.ResFails >= G.fail_num:
		get_tree().change_scene_to_file("res://Assets/Scenes/Fail.tscn")
	pass # Replace with function body.

func _on_x_ray_toggled(toggled_on: bool) -> void:
	if progress == 0:
		progress += 1
		tutorial()
	if progress == 4:
		progress += 1
		tutorial()
	if progress == 9:
		G.Tutorial = false
		get_tree().change_scene_to_file("res://Assets/Scenes/Main.tscn")
	if toggled_on:
		G.IsXray = true
		$Sound/SFX_ItemSelectXRay.play()
		exclusive_toggle($"UI/X-Ray".name)
	else:
		G.IsXray = false
	$Boxes.toggle_xray()

func _on_stethoscope_toggled(toggled_on: bool) -> void:
	if progress == 6:
		progress += 1
		tutorial()
	if toggled_on:
		G.IsStetho = true
		exclusive_toggle($UI/Stethoscope.name)
		$Sound/SFX_ItemSelectStethoscope.play()
	else:
		G.IsStetho = false
		$"Default Listener".make_current()
	$Boxes.toggle_stetho()
func _on_tuna_toggled(toggled_on: bool) -> void:
	if toggled_on:
		exclusive_toggle($UI/Tuna.name)
		$Sound/SFX_ItemSelectTuna.play()
		G.IsTuna = true
	else:
		G.IsTuna = false
		pass
	$Boxes.toggle_tuna()

func _on_knife_toggled(toggled_on: bool) -> void:
	if progress == 2:
		progress += 1
		tutorial()
	if toggled_on:
		G.IsKnife = true
		exclusive_toggle($UI/KNIFE.name)
	else:
		G.IsKnife = false
	$Boxes.toggle_knife()
func _on_pspsps_pressed() -> void:
	pass # Replace with function body.


func _on_blink_timer_timeout() -> void:
	$BG.play()
	$Timers/BlinkTimer.start(randf_range(5.0,10.0))


func should_you_shake(obj: Node): # THE JANK IS REAL
	if tuna_bool:
		obj.shake()

func _on_area_2d_area_entered(area: Area2D) -> void:
	if progress == 1:
		progress += 1
		tutorial()
	if progress == 5:
		progress += 1
		tutorial()
	if progress == 7:
		progress += 1
		tutorial()
	if G.IsTuna:
		if area.get_parent().get_parent().get("cont_obj"):
			if area.get_parent().get_parent().cont_obj.is_tuna:
				tuna_bool = true
			else:
				tuna_bool = false
		call_deferred("should_you_shake", area.get_parent().get_parent())
