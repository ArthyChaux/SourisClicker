extends Control


enum SHOW_STATUS { CLOSE, LITTLE, BIG }
onready var show_status = SHOW_STATUS.CLOSE


func show_menu_little():
	$SkinMenuHandle/AnimationPlayer.play("open_skin_menu_little")
	show_status = SHOW_STATUS.LITTLE

func hide_menu_little():
	$SkinMenuHandle/AnimationPlayer.play_backwards("open_skin_menu_little")
	show_status = SHOW_STATUS.CLOSE

func show_menu_big():
	$SkinMenuHandle/AnimationPlayer.play("open_skin_menu_big")
	show_status = SHOW_STATUS.BIG

func hide_menu_big():
	$SkinMenuHandle/AnimationPlayer.play_backwards("open_skin_menu_total")
	show_status = SHOW_STATUS.CLOSE

func toggle_menu():
	if not $SkinMenuHandle/AnimationPlayer.is_playing():
		if show_status == SHOW_STATUS.CLOSE:
			show_menu_little()
		elif show_status == SHOW_STATUS.LITTLE:
			hide_menu_little()
		elif show_status == SHOW_STATUS.BIG:
			hide_menu_big()

#### SIGNALS ####

func _on_UpgradeMenuHandle_pressed():
	toggle_menu()

func _on_MouseSkinMenu_pressed():
	if show_status != SHOW_STATUS.BIG:
		
		# TODO : change panel
		
		show_menu_big()

func _on_ComputerSkinMenu_pressed():
	if show_status != SHOW_STATUS.BIG:
		
		# TODO : change panel
		
		show_menu_big()

func _on_TableSkinMenu_pressed():
	if show_status != SHOW_STATUS.BIG:
		
		# TODO : change panel
		
		show_menu_big()

func _on_OptionMenu_pressed():
	if show_status != SHOW_STATUS.BIG:
		
		# TODO : add popup
		
		show_menu_big()
