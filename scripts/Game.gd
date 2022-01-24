extends Control

"""
TODO List

Save datas in datas.cfg
Succesfully configure upgrade buttons
Add computer background
Show current stats of player ?

"""

#### WEALTH ####

var wealth: int = 0 setget set_wealth
signal wealth_changed(new_wealth)

func set_wealth(new_wealth: int):
	wealth = new_wealth
	emit_signal("wealth_changed", new_wealth)
	GameData.datas["wealth"] = wealth
	GameData.save_datas()

#### WEALTH INCREASE ON CLICK ####

var wealth_increase_on_click: int = 1 setget set_wealth_increase_on_click
signal wealth_increase_on_click_changed(new_wealth_increase_on_click)

func set_wealth_increase_on_click(new_wealth_increase_on_click: int):
	wealth_increase_on_click = new_wealth_increase_on_click
	emit_signal("wealth_increase_on_click_changed", new_wealth_increase_on_click)
	GameData.datas["increase_on_click"] = wealth_increase_on_click
	GameData.save_datas()


func _ready():
	GameData.load_datas()
	self.wealth = GameData.datas["wealth"]
	self.wealth_increase_on_click = GameData.datas["increase_on_click"]
