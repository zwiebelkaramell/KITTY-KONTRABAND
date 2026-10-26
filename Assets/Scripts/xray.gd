extends TextureButton

var cont_obj: Object
var deposit = false
var first_time = true
var initial_position: Vector2
var t = 0
@onready var hitbox = $Contents/Area2D

func _process(delta: float) -> void:
	if deposit:
		t += delta
		if first_time:
			initial_position = $Contents.global_position
			first_time = false
		$Contents.global_position = lerp(initial_position, (Vector2(850,480)), ease(t, 0.2))

func pass_obj(obj: Object):
	cont_obj = obj
	if !cont_obj.is_cat:
		$Contents/AudioStreamPlayer2D.set_volume_linear(0.0)
	elif cont_obj.difficulty < 1 && randi_range(0,1) == 0:
		$Contents/AudioStreamPlayer2D.set_volume_linear(0.0)


func shake():
	$Contents/AnimationPlayer.play("shake_xray")
	
