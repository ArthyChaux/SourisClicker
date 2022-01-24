extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)
export var racine_path: NodePath
onready var racine: Control = get_node(racine_path)



const base_price: int = 150
var price: int setget ,get_price
var upgrade_level: int = 0
var upgrade_price_steps: int = 50

func get_price():
	return base_price + upgrade_level*upgrade_level * upgrade_price_steps


func _ready():
	update_button_state()

func buy_an_upgrade():
	if racine.wealth >= self.price:
		upgrade_menu.hide_menu()
		popup.set_text("Tu as ameliore ta souris, well done Gromit !")
		popup.popup()
		
		racine.wealth -= price
		self.upgrade_level += 1
		update_button_state()
		
		racine.wealth_increase_on_click += 1
	
	else:
		popup.set_text("Economise encore un peu")
		popup.popup()



func update_button_state():
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = "niv." + str(upgrade_level) + ", " + str(self.price) + "C"
	if racine.wealth >= price:
		$Button.modulate = Color("ffffff")
	else:
		$Button.modulate = Color("ff2b2b")


func _on_Racine_wealth_changed(new_wealth):
	update_button_state()
