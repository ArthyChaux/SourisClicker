extends Control


"""
  -- TODO --

regler problemes de pixel perfect ecran
chemins virus

"""

#### MEMBERS ####

func _ready():
	randomize()
	
	GameData.load_datas()

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
