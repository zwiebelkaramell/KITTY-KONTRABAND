extends Node2D

func _process(delta: float) -> void:
	$BackBufferCopy/Mask.global_position = get_viewport().get_mouse_position()
	
func toggle_xray():
	if !G.IsXray:
		$BackBufferCopy/Mask.visible = false
	else:
		$BackBufferCopy/Mask.visible = true
