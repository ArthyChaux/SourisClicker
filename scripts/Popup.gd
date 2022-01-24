extends PanelContainer

func popup():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("show_popup")

func set_text(text: String):
	$MarginContainer/VBoxContainer/PopupDesc.text = text

func _on_DismissPopupButton_pressed():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play_backwards("show_popup")
