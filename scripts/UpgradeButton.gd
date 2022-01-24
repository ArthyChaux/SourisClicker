extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)
export var racine_path: NodePath
onready var racine: Control = get_node(racine_path)


func buy_an_upgrade():
	if racine.wealth >= 150:
		upgrade_menu.hide_menu()
		popup.set_text("Tu as ameliore ta souris, well done Gromit !")
		popup.popup()
		racine.wealth -= 150
		racine.wealth_increase_on_click += 1
		
	else:
		popup.set_text("Economise encore un peu")
		popup.popup()


func update_button_state():
	pass


func _on_Racine_wealth_changed(new_wealth):
	if new_wealth >= 150:
		$Button.modulate = Color("ffffff")
	else:
		$Button.modulate = Color("ff2b2b")
