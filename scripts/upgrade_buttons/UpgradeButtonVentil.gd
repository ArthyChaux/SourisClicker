extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)

#### MEMBERS ####

func _ready():
	GameData.connect("wealth_changed", self, "update_button_state")
	GameData.connect("ventil_level_changed", self, "update_button_state")

func buy_an_upgrade():
	if GameData.wealth >= GameData.ventil_upgrade_price:
		GameData.wealth -= GameData.ventil_upgrade_price
		GameData.ventil_level += 1
		
		for ventil_key in GameData.upgrades_data["ventil"]["ventils_list"]:
			if GameData.ventil_level == GameData.upgrades_data["ventil"][ventil_key]["unlock_level"]:
				upgrade_menu.hide_menu()
				
				GameData.ventil_skin = ventil_key
				
				popup.set_text(GameData.upgrades_data["ventil"][ventil_key]["unlock_message"])
				popup.popup()
	
	else:
		popup.set_text("economise_un_peu_message")
		popup.popup()

func update_button_state(_nothing = null):
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_level_desc") % [GameData.ventil_level, GameData.ventil_upgrade_price]
	
	if GameData.ventil_level >= GameData.upgrades_data["ventil"]["max_upgrade_level"]:
		$Button.modulate = Color("828282")
		$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_max_level_desc") % [GameData.ventil_level]
		$Button.disabled = true
	
	else:
		if GameData.wealth >= GameData.ventil_upgrade_price:
			$Button.modulate = Color("ffffff")
		else:
			$Button.modulate = Color("ff2b2b")

