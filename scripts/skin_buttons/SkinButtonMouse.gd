extends MarginContainer


export var skin_menu_path: NodePath
onready var skin_menu: Control = get_node(skin_menu_path)

export var skin_name: String

func _ready():
	GameData.connect("mouse_skin_changed", self, "_mouse_skin_changed")
	GameData.connect("mouse_level_changed", self, "_mouse_level_changed")

func _mouse_skin_changed(new_mouse_skin):
	if new_mouse_skin == skin_name:
		set_button_current_skin()
	
	elif GameData.mouse_level >= GameData.upgrades_data["mouse"][skin_name]["unlock_level"]:
		set_button_available()

func _mouse_level_changed(new_mouse_level):
	if new_mouse_level >= GameData.upgrades_data["mouse"][skin_name]["unlock_level"]:
		set_button_available()
	
	else:
		set_button_disabled()


func set_button_current_skin():
	var data = GameData.upgrades_data["mouse"][skin_name]
	
	modulate = Color("ffffff")
	$MarginContainer/HBoxContainer/Icon.texture = load(data["texture"])
	$MarginContainer/HBoxContainer/TitleLabel.text = data["skin_menu_name"]
	
	$Button.modulate = Color("00bcff")
	$Button.disabled = true

func set_button_available():
	var data = GameData.upgrades_data["mouse"][skin_name]
	
	modulate = Color("ffffff")
	$MarginContainer/HBoxContainer/Icon.texture = load(data["texture"])
	$MarginContainer/HBoxContainer/TitleLabel.text = data["skin_menu_name"]
	
	$Button.modulate = Color("ffffff")
	$Button.disabled = false

func set_button_disabled():
	modulate = Color("828282")
	$MarginContainer/HBoxContainer/Icon.texture = null
	$MarginContainer/HBoxContainer/TitleLabel.text = ""
	
	$Button.modulate = Color("ffffff")
	$Button.disabled = true


func _on_SkinButton_pressed():
	GameData.mouse_skin = skin_name
	
	skin_menu.hide_menu_big()
