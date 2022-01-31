extends MarginContainer


export var skin_menu_path: NodePath
onready var skin_menu: Control = get_node(skin_menu_path)
export var mouse_path: NodePath
onready var mouse: TextureButton = get_node(mouse_path)


export var texture: Texture
export var tex_ture: Texture

export var skin_name: String

func _on_SkinButton_pressed():
	mouse.texture_normal = texture
	mouse.texture_pressed = tex_ture
	
	GameData.datas["mouse_skin"] = skin_name
	
	skin_menu.hide_menu_big()
