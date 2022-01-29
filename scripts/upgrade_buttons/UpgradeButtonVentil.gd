extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)
export var racine_path: NodePath
onready var racine: Control = get_node(racine_path)
export var computer_path: NodePath
onready var computer: Sprite = get_node(computer_path)


#### PRICE ####

var price: int setget ,get_price

func get_price():
	return base_price + upgrade_level*upgrade_level * upgrade_price_steps

#### UPGRADE LEVEL ####

var upgrade_level: int = 1 setget set_upgrade_level

func set_upgrade_level(new_upgrade_level):
	upgrade_level = new_upgrade_level
	GameData.datas["ventil_level"] = new_upgrade_level
	
	update_button_state()
	
	computer.heat_loose_factor = atan(0.015 * upgrade_level) * 2/PI
	computer.heat_increase_on_click = 0.5 / float(upgrade_level)
	
	if false: # TODO !!!!!!!!!!
		upgrade_menu.hide_menu()
		popup.set_text("Ta nouvelle ventilation va cartonner !")
		popup.popup()

var base_price: int = GameData.upgrades_data["ventil"]["start_price"]
var upgrade_price_steps: int = GameData.upgrades_data["ventil"]["step_price"]

#### MEMBERS ####

func _ready():
	GameData.connect("_data_loaded", self, "data_loaded")

func data_loaded():
	self.upgrade_level = GameData.datas["ventil_level"]
	
	# TODO : set skin ?
	
	update_button_state()


func buy_an_upgrade():
	if racine.wealth >= self.price:
		racine.wealth -= self.price
		self.upgrade_level += 1
	
	else:
		popup.set_text("economise_un_peu_message")
		popup.popup()



func update_button_state():
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_level_desc") % [upgrade_level, self.price]
	
	if upgrade_level >= GameData.upgrades_data["ventil"]["max_upgrade_level"]:
		$Button.modulate = Color("828282")
		$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_max_level_desc") % [upgrade_level]
		$Button.disabled = true
	
	else:
		if racine.wealth >= self.price:
			$Button.modulate = Color("ffffff")
		else:
			$Button.modulate = Color("ff2b2b")


func _on_Racine_wealth_changed(new_wealth):
	update_button_state()
