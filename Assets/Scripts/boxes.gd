extends Node2D

func _process(delta: float) -> void:
	$BackBufferCopy/Mouse.global_position = get_viewport().get_mouse_position()
	if G.IsKnife:
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$BackBufferCopy/Mouse/Knife.rotation = deg_to_rad(45)
		else:
			$BackBufferCopy/Mouse/Knife.rotation = deg_to_rad(60)

func toggle_xray():
	if !G.IsXray:
		$BackBufferCopy/Mouse/Mask.visible = false
	else:
		$BackBufferCopy/Mouse/Mask.visible = true

func toggle_stetho():
	if G.IsStetho:
		$BackBufferCopy/Mouse/Mask/AudioListener2D.make_current()
		$"BackBufferCopy/Mouse/1StLongStethistcopeThroat".visible = true
	else:
		$BackBufferCopy/Mouse/Mask/AudioListener2D.clear_current()
		$"BackBufferCopy/Mouse/1StLongStethistcopeThroat".visible = false
		
func toggle_tuna():
	if G.IsTuna:
		$BackBufferCopy/Mouse/Tuna.visible = true
	else:
		$BackBufferCopy/Mouse/Tuna.visible = false
		
func toggle_knife():
	if G.IsKnife:
		$BackBufferCopy/Mouse/Knife.visible = true
	else:
		$BackBufferCopy/Mouse/Knife.visible = false
