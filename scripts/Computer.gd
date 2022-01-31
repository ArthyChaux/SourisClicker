extends Sprite


onready var racine: Control = get_parent().get_parent()
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)

#### HEAT ####

export var fumee_anim_speed_profile: Curve
export var fumee_lifetime_profile: Curve
export var fan_pitch_profile: Curve

#normal at 20 and exploses at 120
var heat: float = 20.0 setget set_heat

func set_heat(new_heat):
	heat = new_heat
	
	$Thermometre.value = lerp($Thermometre.value, heat, 0.3)
	
	var factor = 0.01 * lerp($Thermometre.value, heat, 0.1) - 0.2
	
	if new_heat > 120.0 and not $Feu/FeuAnimationPlayer.is_playing():
		$Feu/FeuAnimationPlayer.play("explode")
		print("Ordinateur cramé ! (", heat, "°C)")
		
		$FanAudioStreamPlayer.is_running = false
		$FanAudioStreamPlayer.stop()
		
		factor = 1
		
		$Fumee.lifetime = 0.3
		$Fumee.anim_speed = 0.7
	
	elif new_heat > 120.0:
		factor = 1
		$Fumee.lifetime = 0.3
		$Fumee.anim_speed = 0.7
	
	elif new_heat > 95.0:
		$OverHeatAlert.show()
	
		#Fumee interpolation
		$Fumee.lifetime = 264400*pow(heat, -2.81)
		$Fumee.anim_speed = 59*pow(heat, -0.9)
	
	else:
		$OverHeatAlert.hide()
	
		#Fumee interpolation
		$Fumee.lifetime = 264400*pow(heat, -2.81)
		$Fumee.anim_speed = 59*pow(heat, -0.9)
	
	$Fumee.lifetime = fumee_lifetime_profile.interpolate_baked(factor)
	$Fumee.anim_speed = fumee_anim_speed_profile.interpolate_baked(factor)
	$FanAudioStreamPlayer.pitch_scale = fan_pitch_profile.interpolate_baked(factor)


var heat_increase_on_click: float = 0.5 setget set_heat_increase_on_click

func set_heat_increase_on_click(new_heat_increase_on_click):
	heat_increase_on_click = new_heat_increase_on_click
	GameData.datas["heat_increase_on_click"] = heat_increase_on_click

#Loose **heat_loose_factor * (heat - 20.0)** per decisecond
var heat_loose_factor: float = 0.02 setget set_heat_loose_factor

func set_heat_loose_factor(new_heat_loose_factor):
	heat_loose_factor = new_heat_loose_factor
	GameData.datas["heat_loose_factor"] = new_heat_loose_factor

#### ANTIVIRUS ####

export var upgrade_antivirus_button_path: NodePath
onready var upgrade_antivirus_button: MarginContainer = get_node(upgrade_antivirus_button_path)

var antivirus_expiration_duration = 0 setget set_antivirus_expiration_duration

func set_antivirus_expiration_duration(new_antivirus_expiration_duration, by_timer = false):
	if new_antivirus_expiration_duration >= 0:
		antivirus_expiration_duration = new_antivirus_expiration_duration
		GameData.datas["antivirus_expiration_duration"] = new_antivirus_expiration_duration
	
	if new_antivirus_expiration_duration == 0:
		if by_timer:
			upgrade_antivirus_button.upgrade_level = 0
			print("Antivirus expired")
		antivirus_proba_tue_virus = 0
		$AntivirusCountDownTickTimer.stop()
	
	elif antivirus_expiration_duration > 0 and $AntivirusCountDownTickTimer.is_stopped():
		$AntivirusCountDownTickTimer.start()
	
	$AntivirusShower.update_text(self.antivirus_expiration_duration)

var antivirus_proba_tue_virus = 0 setget set_antivirus_proba_tue_virus

func set_antivirus_proba_tue_virus(new_antivirus_proba_tue_virus):
	antivirus_proba_tue_virus = new_antivirus_proba_tue_virus
	GameData.datas["antivirus_proba_tue_virus"] = new_antivirus_proba_tue_virus

#### AUTOCLICK ####

var click_per_seconds = 0 setget set_click_per_seconds

func set_click_per_seconds(new_click_per_seconds):
	click_per_seconds = new_click_per_seconds
	GameData.datas["click_per_seconds"] = new_click_per_seconds
	
	$AutoClickShower.update_text(click_per_seconds)

#### MEMBERS ####

var backup = {}

func _ready():
	GameData.connect("_data_loaded", self, "data_loaded")
	
	$FanAudioStreamPlayer.start_fanning()

func data_loaded():
	self.heat_loose_factor = GameData.datas["heat_loose_factor"]
	self.antivirus_expiration_duration = GameData.datas["antivirus_expiration_duration"]
	$AntivirusShower.update_text(self.antivirus_expiration_duration)
	self.antivirus_proba_tue_virus = GameData.datas["antivirus_proba_tue_virus"]
	self.click_per_seconds = GameData.datas["click_per_seconds"]
	backup = GameData.datas


#### SIGNALS ####

func _on_Mouse_pressed():
	racine.wealth += racine.wealth_increase_on_click
	self.heat += heat_increase_on_click * racine.wealth_increase_on_click
	$MouseAudioStreamPlayer.random_play()

func _on_CoolTimer_timeout():
	self.heat -= heat_loose_factor * (heat - 20.0)

func _on_FeuAnimationPlayer_animation_finished(anim_name):
	if anim_name == "explode":
		$Feu/FeuAnimationPlayer.play("burn")
		print("L'ordi brule")
		
		yield(get_tree().create_timer(5), "timeout")
		
		popup.set_text(tr("backup_restore_after_ordi_burn_message"))
		popup.popup()
		print("Ordinateur back and running")
		popup.connect("_popup_closed", self, "restore_backup")
		
		#TODO : looase things

func restore_backup():
	GameData.can_save_data = false
	GameData.save_datas(backup, true)
	
	print("Saved backup as datas : ", JSON.print(backup, "\t"))
	print("Reloading scene")
	get_tree().reload_current_scene()

func _on_AntivirusTickTimer_timeout():
	self.set_antivirus_expiration_duration(antivirus_expiration_duration-1, true)

func _on_AutoclickTimer_timeout():
	racine.wealth += click_per_seconds
	self.heat += heat_increase_on_click * click_per_seconds
