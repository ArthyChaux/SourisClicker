extends MarginContainer


export var skin_menu_path: NodePath
onready var skin_menu: Control = get_node(skin_menu_path)
export var mouse_path: NodePath
onready var mouse: TextureButton = get_node(mouse_path)


export var texture: Texture
export var tex_ture: Texture

func _on_SkinButton_pressed():
	mouse.texture_normal = texture
	mouse.texture_pressed = tex_ture
	
	skin_menu.hide_menu_big()
