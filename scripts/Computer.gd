extends Sprite


onready var racine: Control = get_parent().get_parent()
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)

#### HEAT ####

var heat: float = base_heat setget set_heat

func set_heat(new_heat):
	heat = new_heat
	
	if new_heat > max_heat_possible:
		$Feu/FeuAnimationPlayer.play("explode")
		print("Ordinateur cramé")
		
		$Fumee.lifetime = 0.5
		$Fumee.anim_speed = 1
	
	#TODO : linear interpolation !
	elif new_heat > base_heat + 3*(max_heat_possible-base_heat) / 4:
		$Fumee.lifetime = 0.5
		$Fumee.anim_speed = 1
		$OverHeatAlert.show()
	elif new_heat > base_heat + 2*(max_heat_possible-base_heat) / 4:
		$Fumee.lifetime = 2
		$Fumee.anim_speed = 1.5
		$OverHeatAlert.hide()
	elif new_heat > base_heat + (max_heat_possible-base_heat) / 4:
		$Fumee.lifetime = 8
		$Fumee.anim_speed = 2
		$OverHeatAlert.hide()
	else:
		$Fumee.lifetime = 50
		$Fumee.anim_speed = 4
		$OverHeatAlert.hide()

const base_heat: float = 20.0

#Above it, computer overheat
const max_heat_possible: float = 100.0
var heat_increase_on_click: float = 0.5

#Loose **heat_loose_factor * (heat - base_heat)** per decisecond
var heat_loose_factor: float = 0.02

#### ANTIVIRUS ####

export var upgrade_antivirus_button_path: NodePath
onready var upgrade_antivirus_button: MarginContainer = get_node(upgrade_antivirus_button_path)

var antivirus_expiration_duration = 0 setget set_antivirus_expiration_duration

func set_antivirus_expiration_duration(new_antivirus_expiration_duration):
	#if >0 launch timer / set truc
	# if <0 stop timer
	
	if true: # TODO !!!!!!!!!!!!!!
		antivirus_expiration_duration = new_antivirus_expiration_duration
		GameData.datas["antivirus_expiration_duration"] = new_antivirus_expiration_duration
		GameData.soft_save_datas()
		
		upgrade_antivirus_button.update_button_state()

var antivirus_proba_tue_virus = 0

#### AUTOCLICK ####

var click_per_seconds = 0

#### MEMBERS ####

func _ready():
	GameData.connect("_data_loaded", self, "data_loaded")

func data_loaded():
	self.heat_loose_factor = GameData.datas["heat_loose_factor"]
	self.antivirus_expiration_duration = GameData.datas["antivirus_expiration_duration"]
	self.antivirus_proba_tue_virus = GameData.datas["antivirus_proba_tue_virus"]
	self.click_per_seconds = GameData.datas["click_per_seconds"]
	

#### SIGNALS ####

func _on_Mouse_pressed():
	racine.wealth += racine.wealth_increase_on_click
	self.heat += heat_increase_on_click * racine.wealth_increase_on_click

func _on_CoolTimer_timeout():
	self.heat -= heat_loose_factor * (heat - base_heat)

func _on_FeuAnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		$Feu/FeuAnimationPlayer.play("burn")
		print("l'ordi brule")
		
		yield(get_tree().create_timer(5), "timeout")
		
		popup.set_text("Tu as retrouve une backup de ta partie, tu vas pouvoir continuer.")
		popup.popup()
		print("Back and running")
		
		$Feu/FeuAnimationPlayer.play("RESET")
		
		#TODO : looase things

func _on_AntivirusTickTimer_timeout():
	self.antivirus_expiration_duration -= 1

func _on_AutoclickTimer_timeout():
	racine.wealth += click_per_seconds
