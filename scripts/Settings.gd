extends Panel


func _ready():
	GameData.connect("locale_changed", self, "locale_changed")

func popup():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("open_settings")

func locale_changed(new_locale):
#	print("locale changed for ", new_locale)
	for idx in range($MarginContainer/VBoxContainer/HBoxContainer/OptionButton.get_item_count()):
#		print("testing locale ", $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.get_item_text(idx))
		if $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.get_item_text(idx) == new_locale:
#			print("right one, selecting it !")
			$MarginContainer/VBoxContainer/HBoxContainer/OptionButton.select(idx)
	
	


func _on_OptionButton_item_selected(index):
	var l = $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.get_item_text(index)
	GameData.locale = l

func _on_CloseSettingsButton_pressed():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play_backwards("open_settings")

func _on_ReinitaliseButton_pressed():
	print("Resetting datas")
	GameData.can_save_data = false
	
	print("Stop saving possible")
	GameData.save_datas(GameData.base_data, true)
	
	print("Saved base_data as datas : ", JSON.print(GameData.base_data, "\t"))
	print("Reloading scene")
	get_tree().reload_current_scene()


func _on_CheckButton_toggled(button_pressed):
	get_parent().get_parent().get_node("CanvasLayer/ColorRect").visible = button_pressed
	$MarginContainer/VBoxContainer/HBoxContainer3/CheckButton.text = "active" if button_pressed else "desactive"
