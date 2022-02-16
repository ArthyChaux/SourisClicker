extends Control


#### MEMBERS ####

func _ready():
	randomize()
	
	GameData.load_datas()
	
	GameData.is_currently_saving = false
	GameData.can_save_data = true

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
