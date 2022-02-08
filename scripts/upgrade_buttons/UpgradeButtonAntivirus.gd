extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)

#### MEMBERS ####

func _ready():
	GameData.connect("wealth_changed", self, "update_button_state")
	GameData.connect("antivirus_level_changed", self, "update_button_state")
	GameData.connect("antivirus_duration_changed", self, "update_button_state")


func buy_an_upgrade():
	if GameData.wealth >= GameData.antivirus_upgrade_price and GameData.antivirus_duration > 0:
		GameData.wealth -= GameData.antivirus_upgrade_price
		GameData.antivirus_level += 1
		
		for antivirus_key in GameData.upgrades_data["antivirus"]["antivirus_list"]:
			if GameData.antivirus_level == GameData.upgrades_data["antivirus"][antivirus_key]["unlock_level"]:
				upgrade_menu.hide_menu()
				
				GameData.antivirus_skin = antivirus_key
				
				popup.set_text(GameData.upgrades_data["antivirus"][antivirus_key]["unlock_message"])
				popup.popup()
	
	elif GameData.antivirus_duration <= 0:
		popup.set_text("met_antivirus_a_jour_avant_de_lameliorer_message")
		popup.popup()
		
	else:
		popup.set_text("economise_un_peu_message")
		popup.popup()

func update_button_state(_nothing = null):
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_antivirus_desc") % [GameData.antivirus_level, GameData.antivirus_upgrade_price, int(GameData.antivirus_proba_tue_virus*10000)/100.0]
	
	if GameData.antivirus_level >= GameData.upgrades_data["antivirus"]["max_upgrade_level"]:
		$Button.modulate = Color("828282")
		$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_antivirus_max_level_desc") % [GameData.antivirus_level, int(GameData.antivirus_proba_tue_virus/100)]
		$Button.disabled = true
	
	else:
		$Button.disabled = false
		if GameData.wealth >= GameData.antivirus_upgrade_price and GameData.antivirus_duration > 0:
			$Button.modulate = Color("ffffff")
		else:
			$Button.modulate = Color("ff2b2b")
