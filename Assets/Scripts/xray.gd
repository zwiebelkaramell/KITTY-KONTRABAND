extends TextureButton

var cont_obj: Object

@onready var hitbox = $Contents/Area2D

func pass_obj(obj: Object):
	cont_obj = obj
	if !cont_obj.is_cat:
		$Contents/AudioStreamPlayer2D.set_volume_linear(0.0)
	elif cont_obj.difficulty < 1 && randi_range(0,1) == 0:
		$Contents/AudioStreamPlayer2D.set_volume_linear(0.0)


func shake():
	$Contents/AnimationPlayer.play("shake_xray")
