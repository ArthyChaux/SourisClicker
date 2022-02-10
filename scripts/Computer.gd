extends Sprite


onready var racine: Control = get_parent().get_parent()
export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)


export var texture_wire_off: Texture
export var texture_wire_ok: Texture
export var texture_wire_wrong: Texture
export var texture_wireless_off: Texture
export var texture_wireless_ok: Texture
export var texture_wireless_wrong: Texture


#### HEAT ####

export var fumee_lifetime_profile: Curve
export var fan_pitch_profile: Curve

signal exploded()

#normal at 20 and exploses at 120
var heat: float = 20.0 setget set_heat

func set_heat(new_heat):
	$Thermometre.value = new_heat
	
	var factor = 0.01 * lerp(heat, new_heat, 0.3) - 0.2
	
	if new_heat > 120.0 and not $Feu/FeuAnimationPlayer.is_playing():
		$Feu/FeuAnimationPlayer.play("explode")
		print("Ordinateur cramé ! (", new_heat, "°C)")
		
		$FanAudioStreamPlayer.is_running = false
		$FanAudioStreamPlayer.stop()
		
		factor = 1
		emit_signal("exploded")
	
	elif new_heat > 120.0:
		factor = 1
	
	elif new_heat > 95.0:
		$OverHeatAlert.is_to_remain_shown = true
	
	else:
		$OverHeatAlert.is_to_remain_shown = false
	
	$FanAudioStreamPlayer.pitch_scale = fan_pitch_profile.interpolate_baked(factor)
	
	heat = new_heat


#Loose **heat_loose_factor * (heat - 20.0)** per decisecond
var heat_loose_factor: float = 0.02

#### ANTIVIRUS ####

func _antivirus_duration_changed(new_antivirus_duration):
	if new_antivirus_duration <= 0 and not $AntivirusCountDownTickTimer.is_stopped():
		$AntivirusCountDownTickTimer.stop()
		popup.set_text("antivirus_expire_message")
		popup.popup()
	
	elif new_antivirus_duration > 0 and $AntivirusCountDownTickTimer.is_stopped():
		$AntivirusCountDownTickTimer.start()

#### MEMBERS ####

var backup = {}

func _ready():
	GameData.connect("_data_loaded", self, "data_loaded")
	GameData.connect("_data_saved", self, "data_saved")
	GameData.connect("antivirus_duration_changed", self, "_antivirus_duration_changed")
	GameData.connect("mouse_skin_changed", self, "set_new_wireless")
	GameData.connect("ventil_skin_changed", self, "set_textures")
	
	$FanAudioStreamPlayer.start_fanning()

func data_loaded():
	backup = GameData.datas

func data_saved(is_error):
	if GameData.upgrades_data.mouse[GameData.mouse_skin]["wireless"]:
		if is_error:
			texture = texture_wireless_wrong
		else:
			texture = texture_wireless_ok
		$ResetComputerSkinTimer.start()
	
	else:
		if is_error:
			texture = texture_wire_wrong
		else:
			texture = texture_wire_ok
		$ResetComputerSkinTimer.start()

func set_new_wireless(new_mouse_skin: String):
	if GameData.upgrades_data.mouse[new_mouse_skin]["wireless"]:
		texture = texture_wireless_off
	
	else:
		texture = texture_wire_off

func set_textures(new_ventil_skin: String):
	texture_wire_off = load(GameData.upgrades_data.ventil[new_ventil_skin]["texture_wire_off"])
	texture_wire_ok = load(GameData.upgrades_data.ventil[new_ventil_skin]["texture_wire_ok"])
	texture_wire_wrong = load(GameData.upgrades_data.ventil[new_ventil_skin]["texture_wire_wrong"])
	texture_wireless_off = load(GameData.upgrades_data.ventil[new_ventil_skin]["texture_wireless_off"])
	texture_wireless_ok = load(GameData.upgrades_data.ventil[new_ventil_skin]["texture_wireless_ok"])
	texture_wireless_wrong = load(GameData.upgrades_data.ventil[new_ventil_skin]["texture_wireless_wrong"])
	
	set_new_wireless(GameData.mouse_skin)

func _on_ResetComputerSkinTimer_timeout():
	if GameData.upgrades_data.mouse[GameData.mouse_skin]["wireless"]:
		texture = texture_wireless_off
	
	else:
		texture = texture_wire_off

#### SIGNALS ####

func _on_Mouse_pressed():
	GameData.wealth += GameData.wealth_increase_on_click
	self.heat += GameData.heat_increase_on_click * GameData.wealth_increase_on_click
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

func restore_backup():
	GameData.can_save_data = false
	GameData.save_datas(backup, true)
	
	print("Saved backup as datas : ", JSON.print(backup, "\t"))
	print("Reloading scene")
	get_tree().reload_current_scene()

func _on_AntivirusTickTimer_timeout():
	GameData.antivirus_duration -= 1

func _on_AutoclickTimer_timeout():
	GameData.wealth += GameData.clicks_per_seconds
	self.heat += GameData.heat_increase_on_click * GameData.clicks_per_seconds


