extends MarginContainer


export var upgrade_menu_path: NodePath
onready var upgrade_menu: Control = get_node(upgrade_menu_path)
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)


#### PRICE ####

var price: int = 500

#### MEMBERS ####

func _ready():
	GameData.connect("wealth_changed", self, "update_button_state")


func buy_an_upgrade():
	if GameData.wealth >= self.price:
		GameData.wealth -= self.price
		
		GameData.antivirus_duration += 120
		$AudioStreamPlayer.play()
	
	else:
		popup.set_text("economise_un_peu_message")
		popup.popup()

func update_button_state(_nothing = null):
	$MarginContainer/HBoxContainer/VBoxContainer/PriceLabel.text = tr("upgrade_under_tab_no_level_desc") % [price]
	
	if GameData.wealth >= self.price:
		$Button.modulate = Color("ffffff")
	else:
		$Button.modulate = Color("ff2b2b")
