extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)

#### MEMBERS ####

func _ready():
	GameData.connect("wealth_changed", self, "update_button_state")
	GameData.connect("antivirus_level_changed", self, "update_button_state")


func buy_an_upgrade():
	if GameData.wealth >= GameData.table_upgrade_price:
		GameData.wealth -= GameData.table_upgrade_price
		GameData.table_level += 1
		
		for table_key in GameData.upgrades_data["table"]["table_list"]:
			if GameData.table_level == GameData.upgrades_data["table"][table_key]["unlock_level"]:
				upgrade_menu.hide_menu()
				
				GameData.table_skin = table_key
				
				popup.set_text(GameData.upgrades_data["table"][table_key]["unlock_message"])
				popup.popup()
	
	else:
		popup.set_text("economise_un_peu_message")
		popup.popup()

func update_button_state(_nothing = null):
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_no_level_desc") % [GameData.table_upgrade_price]
	
	if GameData.table_level >= GameData.upgrades_data["table"]["max_upgrade_level"]:
		$Button.modulate = Color("828282")
		$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_max_level_desc") % [GameData.table_level]
		$Button.disabled = true
	
	else:
		if GameData.wealth >= GameData.table_upgrade_price:
			$Button.modulate = Color("ffffff")
		else:
			$Button.modulate = Color("ff2b2b")
