extends Control


enum SHOW_STATUS { CLOSE, LITTLE, BIG }
onready var show_status = SHOW_STATUS.CLOSE

export var button_skin_choose: PackedScene
onready var skin_list_node = $MenuBackgroundOutline/HBoxContainer/Control/MarginContainer/ScrollContainer/SkinList

#### FUNC SHOW / HIDE MENU #####

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
	for child in skin_list_node.get_children():
		if child is MarginContainer:
			skin_list_node.remove_child(child)
			child.queue_free()
	
	for mouse_key in GameData.upgrades_data["mouse"]["mouses_list"]:
		var button: MarginContainer = button_skin_choose.instance()
		skin_list_node.add_child(button)
		
		if GameData.datas["mouse_skin"] == mouse_key:
			var data = GameData.upgrades_data["mouse"][mouse_key]
			button.get_node("MarginContainer/HBoxContainer/Icon").texture = load(data["texture"])
			button.get_node("MarginContainer/HBoxContainer/TitleLabel").text = data["skin_menu_name"]
			
			button.get_node("Button").modulate = Color("00bcff")
			button.get_node("Button").disabled = true
		
		elif GameData.datas["mouse_level"] >= GameData.upgrades_data["mouse"][mouse_key]["unlock_level"]:
			var data = GameData.upgrades_data["mouse"][mouse_key]
			button.get_node("MarginContainer/HBoxContainer/Icon").texture = load(data["texture"])
			button.get_node("MarginContainer/HBoxContainer/TitleLabel").text = data["skin_menu_name"]
			
			button.texture = load(data["texture"])
			button.tex_ture = load(data["tex_ture"])
		
		else:
			button.modulate = Color("828282")
	
	if show_status != SHOW_STATUS.BIG:
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
	$AcceptDialog.popup_centered(Vector2(820, 1500))
