extends TextureButton

var cont_obj: Object

func pass_obj(obj: Object):
	cont_obj = obj
	#if cont_obj.is_cat:
	#	$Contents/AudioStreamPlayer2D.play()
