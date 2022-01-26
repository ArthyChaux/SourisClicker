extends Sprite


onready var racine: Control = get_parent().get_parent()
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)


var heat: float = base_heat setget set_heat

func set_heat(new_heat):
	heat = new_heat
	#$Icon.modulate = temperature_color_gradient.interpolate((heat-base_heat)/(max_heat_possible-base_heat))
	
	if new_heat > base_heat + 3*(max_heat_possible-base_heat) / 4:
		$Fumee.lifetime = 0.5
		$Fumee.anim_speed = 1
	elif new_heat > base_heat + 2*(max_heat_possible-base_heat) / 4:
		$Fumee.lifetime = 2
		$Fumee.anim_speed = 1.5
	elif new_heat > base_heat + (max_heat_possible-base_heat) / 4:
		$Fumee.lifetime = 8
		$Fumee.anim_speed = 2
	else:
		$Fumee.lifetime = 50
		$Fumee.anim_speed = 4
	
	if new_heat > max_heat_possible:
		$Feu/FeuAnimationPlayer.play("explode")

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


func _on_FeuAnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		$Feu/FeuAnimationPlayer.play("burn")
		popup.set_text("OVERHEAT !")
		popup.popup()
