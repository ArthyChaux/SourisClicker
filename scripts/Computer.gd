extends TextureRect


onready var racine: Control = get_parent()
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)


var heat: float = base_heat setget set_heat

func set_heat(new_heat):
	heat = new_heat
	$Icon.modulate = temperature_color_gradient.interpolate((heat-base_heat)/(max_heat_possible-base_heat))

	if new_heat > max_heat_possible:
		popup.set_text("OVERHEAT !")
		popup.popup()

const base_heat: float = 20.0
#Above it, computer overheat
var max_heat_possible: float = 100.0
var heat_increase_on_click: float = 0.5
#Loose **heat_loose_factor * (heat - base_heat)** per decisecond
var heat_loose_factor: float = 0.02

export var temperature_color_gradient: Gradient


func _on_Mouse_pressed():
	racine.wealth += racine.wealth_increase_on_click
	self.heat += heat_increase_on_click * racine.wealth_increase_on_click

func _on_CoolTimer_timeout():
	self.heat -= heat_loose_factor * (heat - base_heat)
