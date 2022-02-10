extends PanelContainer


signal _popup_closed()

func popup():
	if not $AnimationPlayer.is_playing():
		print("Showing popup with message : ", $MarginContainer/VBoxContainer/PopupDesc.text)
		$AnimationPlayer.play("show_popup")

func set_text(text: String):
	$MarginContainer/VBoxContainer/PopupDesc.text = text

func _on_DismissPopupButton_pressed():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play_backwards("show_popup")
		emit_signal("_popup_closed")


func _on_OptionButton_item_selected(index):
	pass # Replace with function body.
