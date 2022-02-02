extends MarginContainer


export var skin_menu_path: NodePath
onready var skin_menu: Control = get_node(skin_menu_path)

export var skin_name: String

func _on_SkinButton_pressed():
	skin_menu.set_mouse_skin(skin_name)
	
	skin_menu.hide_menu_big()
