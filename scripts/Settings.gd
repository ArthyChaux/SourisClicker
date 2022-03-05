extends Panel



func popup():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("open_settings")

#### HANDLE CHANGES  ####

func _ready():
	GameData.connect("locale_changed", self, "locale_changed")
	GameData.connect("is_blacknwhite_changed", self, "is_blacknwhite_changed")
	GameData.connect("is_reverse_screen_changed", self, "is_reverse_screen_changed")
	GameData.connect("is_audio_changed", self, "is_audio_changed")

func locale_changed(new_locale):
#	print("locale changed for ", new_locale)
	for idx in range($MarginContainer/VBoxContainer/LangueBox/LangueOptionButton.get_item_count()):
#		print("testing locale ", $MarginContainer/VBoxContainer/HBoxContainer/OptionButton.get_item_text(idx))
		if $MarginContainer/VBoxContainer/LangueBox/LangueOptionButton.get_item_text(idx) == new_locale:
#			print("right one, selecting it !")
			$MarginContainer/VBoxContainer/LangueBox/LangueOptionButton.select(idx)

func is_blacknwhite_changed(new_is_blacknwhite):
	$MarginContainer/VBoxContainer/BlackNWhiteBox/BlackNWhiteToggle.pressed = new_is_blacknwhite
	get_parent().get_parent().get_node("ScreenEffectsCanvasLayer/ScreenEffects").material.set_shader_param("is_bnw", new_is_blacknwhite)
	$MarginContainer/VBoxContainer/BlackNWhiteBox/BlackNWhiteToggle.text = "active" if new_is_blacknwhite else "desactive"

func is_reverse_screen_changed(new_is_reverse_screen):
	$MarginContainer/VBoxContainer/ReverseScreenBox/ReverseScreenToggle.pressed = new_is_reverse_screen
	get_parent().get_parent().get_node("ScreenEffectsCanvasLayer/ScreenEffects").material.set_shader_param("is_reverse", new_is_reverse_screen)
	$MarginContainer/VBoxContainer/ReverseScreenBox/ReverseScreenToggle.text = "active" if new_is_reverse_screen else "desactive"

func is_audio_changed(new_is_audio):
	$MarginContainer/VBoxContainer/SoundBox/SoundToggle.pressed = new_is_audio
	$MarginContainer/VBoxContainer/SoundBox/SoundToggle.text = "active" if new_is_audio else "desactive"

#### HANDLE BUTTONS ####

func _on_CloseSettingsButton_pressed():
	if not $AnimationPlayer.is_playing():
		$AnimationPlayer.play_backwards("open_settings")

func _on_ReinitaliseButton_pressed():
	print("Stop saving possible")
	GameData.can_save_data = false
	
	print("Resetting datas")
	GameData.save_datas(GameData.base_data, true)
	
	print("Saved base_data as datas : ", JSON.print(GameData.base_data, "\t"))
	print("Reloading scene")
	get_tree().reload_current_scene()


func _on_LangueOptionButton_item_selected(index):
	var l = $MarginContainer/VBoxContainer/LangueBox/LangueOptionButton.get_item_text(index)
	GameData.locale = l


func _on_BlackNWhiteToggle_toggled(button_pressed):
	GameData.set_is_blacknwhite(button_pressed)

func _on_ReverseScreenToggle_toggled(button_pressed):
	GameData.set_is_reverse_screen(button_pressed)

func _on_SoundToggle_toggled(button_pressed):
	GameData.set_is_audio(button_pressed)
