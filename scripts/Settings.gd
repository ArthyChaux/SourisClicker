extends Panel



func popup():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("open_settings")


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



func _on_OptionButton_item_selected(index):
	var l = $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.get_item_text(index)
	GameData.locale = l
