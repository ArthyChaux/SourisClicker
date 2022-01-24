extends Control

"""
TODO List

Save datas in datas.cfg
Succesfully configure upgrade buttons
Add computer background
Show current stats of player ?

"""


var wealth: int = 0 setget set_wealth
var wealth_increase_on_click: int = 1

signal wealth_changed(new_wealth)

func set_wealth(new_wealth: int):
	wealth = new_wealth
	emit_signal("wealth_changed", new_wealth)

func _ready():
	GameData.load_datas()
	self.wealth = GameData.datas["wealth"]
	self.wealth_increase_on_click = GameData.datas["increase_on_click"]

func _on_Mouse_pressed():
	self.wealth += wealth_increase_on_click
	GameData.datas["wealth"] = wealth
	GameData.datas["increase_on_click"] = wealth_increase_on_click
	GameData.save_datas()
