extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)
export var racine_path: NodePath
onready var racine: Control = get_node(racine_path)


var price: int setget ,get_price

func get_price():
	return base_price + upgrade_level*upgrade_level * upgrade_price_steps

var upgrade_level: int = 1 setget set_upgrade_level

func set_upgrade_level(new_upgrade_level):
	upgrade_level = new_upgrade_level
	GameData.datas["mouse_level"] = new_upgrade_level
	GameData.save_datas()
	
	if false: # TODO !!!!!!!!!!
		upgrade_menu.hide_menu()
		popup.set_text("Tu as ameliore ta souris, et elle est bien mieux maintenant !")
		popup.popup()

var base_price: int = GameData.upgrades_data["mouse"]["start_price"]
var upgrade_price_steps: int = GameData.upgrades_data["mouse"]["step_price"]

#### MEMBERS ####

func _ready():
	GameData.connect("_data_loaded", self, "data_loaded")

func data_loaded():
	self.upgrade_level = GameData.datas["mouse_level"]
	
	# TODO : set skin ?
	
	update_button_state()


func buy_an_upgrade():
	if racine.wealth >= self.price:
		racine.wealth -= self.price
		self.upgrade_level += 1
		update_button_state()
		
		racine.wealth_increase_on_click += upgrade_level
	
	else:
		popup.set_text("Economise encore un peu pour ca")
		popup.popup()



func update_button_state():
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = "niv." + str(upgrade_level) + ", " + str(self.price) + "C"
	if racine.wealth >= self.price:
		$Button.modulate = Color("ffffff")
	else:
		$Button.modulate = Color("ff2b2b")


func _on_Racine_wealth_changed(new_wealth):
	update_button_state()
