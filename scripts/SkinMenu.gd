extends Control


enum SHOW_STATUS { CLOSE, LITTLE, BIG }
onready var show_status = SHOW_STATUS.CLOSE

export var mouse_path: NodePath
onready var mouse: TextureButton = get_node(mouse_path)
export var table_path: NodePath
onready var table: TextureRect = get_node(table_path)

export var button_mouse_skin_choose: PackedScene
export var button_computer_skin_choose: PackedScene
export var button_table_skin_choose: PackedScene
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


func hide_menu():
	if show_status == SHOW_STATUS.BIG:
		$SkinMenuHandle/AnimationPlayer.play_backwards("open_skin_menu_total")
	elif show_status == SHOW_STATUS.LITTLE:
		$SkinMenuHandle/AnimationPlayer.play_backwards("open_skin_menu_little")
	show_status = SHOW_STATUS.CLOSE

func toggle_menu():
	if not $SkinMenuHandle/AnimationPlayer.is_playing():
		if show_status == SHOW_STATUS.CLOSE:
			show_menu_little()
		elif show_status == SHOW_STATUS.LITTLE:
			hide_menu_little()
		elif show_status == SHOW_STATUS.BIG:
			hide_menu_big()

#### SKIN VARIABLES ####

func _mouse_skin_changed(new_mouse_skin):
	mouse.texture_normal = load(GameData.upgrades_data["mouse"][new_mouse_skin]["texture"])
	mouse.texture_pressed = load(GameData.upgrades_data["mouse"][new_mouse_skin]["tex_ture"])

func _table_skin_changed(new_table_skin):
	table.texture = load(GameData.upgrades_data.table[new_table_skin]["texture"])

#### MEMBERS ####

func _ready():
	GameData.connect("mouse_skin_changed", self, "_mouse_skin_changed")
#	GameData.connect("autoclick_skin_changed", self, "_autoclick_skin_changed")
#	GameData.connect("antivirus_skin_changed", self, "_antivirus_skin_changed")
	GameData.connect("table_skin_changed", self, "_table_skin_changed")

#### SIGNALS ####

func _on_UpgradeMenuHandle_pressed():
	toggle_menu()

func _on_MouseSkinMenu_pressed():
	$MenuBackgroundOutline/HBoxContainer/Control/MarginContainer/ScrollContainer/SkinList/Label.text = "mouse_skins_menu_title"
	
	for child in skin_list_node.get_children():
		if child is MarginContainer:
			skin_list_node.remove_child(child)
			child.queue_free()
	
	for mouse_key in GameData.upgrades_data["mouse"]["mouses_list"]:
		var button: MarginContainer = button_mouse_skin_choose.instance()
		skin_list_node.add_child(button)
		button.skin_name = mouse_key
		
		if GameData.mouse_skin == mouse_key:
			button.set_button_current_skin()
		
		elif GameData.mouse_level >= GameData.upgrades_data["mouse"][mouse_key]["unlock_level"]:
			button.set_button_available()
		
		else:
			button.set_button_disabled()
		
	
	if show_status != SHOW_STATUS.BIG:
		show_menu_big()

func _on_ComputerSkinMenu_pressed():
	$MenuBackgroundOutline/HBoxContainer/Control/MarginContainer/ScrollContainer/SkinList/Label.text = "ordinateur_skins_menu_title"
	
	for child in skin_list_node.get_children():
		if child is MarginContainer:
			skin_list_node.remove_child(child)
			child.queue_free()
	
	for ventil_key in GameData.upgrades_data["ventil"]["ventils_list"]:
		var button: MarginContainer = button_computer_skin_choose.instance()
		skin_list_node.add_child(button)
		button.skin_name = ventil_key
		
		if GameData.ventil_skin == ventil_key:
			button.set_button_current_skin()
		
		elif GameData.ventil_level >= GameData.upgrades_data["ventil"][ventil_key]["unlock_level"]:
			button.set_button_available()
		
		else:
			button.set_button_disabled()
	
	if show_status != SHOW_STATUS.BIG:
		show_menu_big()

func _on_TableSkinMenu_pressed():
	get_parent().get_parent().get_node("Panel").show()
	get_parent().get_parent().get_node("Panel/MarginContainer/ScrollContainer").scroll_vertical = 0
	
	$MenuBackgroundOutline/HBoxContainer/Control/MarginContainer/ScrollContainer/SkinList/Label.text = "table_skins_menu_title"
	
	for child in skin_list_node.get_children():
		if child is MarginContainer:
			skin_list_node.remove_child(child)
			child.queue_free()
	
	for table_key in GameData.upgrades_data["table"]["table_list"]:
		var button: MarginContainer = button_table_skin_choose.instance()
		skin_list_node.add_child(button)
		button.skin_name = table_key
		
		if GameData.table_skin == table_key:
			button.set_button_current_skin()
		
		elif GameData.table_level >= GameData.upgrades_data.table[table_key]["unlock_level"]:
			button.set_button_available()
		
		else:
			button.set_button_disabled()
	
	if show_status != SHOW_STATUS.BIG:
		show_menu_big()

func _on_OptionMenu_pressed():
	hide_menu()
	get_parent().get_parent().get_node("UPGRADEMENUOffsetNode/UpgradeMenu").hide_menu()
	get_parent().get_parent().get_node("SettingsExclusive/Settings").popup()

