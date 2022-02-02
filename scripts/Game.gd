extends Control


"""
  -- TODO --

regler problemes de pixel perfect ecran
chemins virus

"""










#### WEALTH ####

var wealth: int = 0 setget set_wealth
signal wealth_changed(new_wealth)

func set_wealth(new_wealth: int):
	wealth = new_wealth
	GameData.datas["wealth"] = wealth
	
	emit_signal("wealth_changed", new_wealth)

#### WEALTH INCREASE ON CLICK ####

var wealth_increase_on_click: int = 1 setget set_wealth_increase_on_click
signal wealth_increase_on_click_changed(new_wealth_increase_on_click)

func set_wealth_increase_on_click(new_wealth_increase_on_click: int):
	wealth_increase_on_click = new_wealth_increase_on_click
	GameData.datas["increase_on_click"] = wealth_increase_on_click
	
	emit_signal("wealth_increase_on_click_changed", new_wealth_increase_on_click)

#### MEMBERS ####

#To have it good at _ready()
func _ready():
	randomize()
	
	GameData.connect("_data_loaded", self, "data_loaded")
	GameData.load_datas()

func data_loaded():
	self.wealth = GameData.datas["wealth"]
	self.wealth_increase_on_click = GameData.datas["increase_on_click"]
