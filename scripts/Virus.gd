extends Node2D

onready var computer = get_parent()

export var is_infested: bool = false
var can_come: bool = true


var current_virus_name: String
var current_virus_speed: int


func virus_move_along_curve():
	var duration = $BackBufferCopy/VirusMovePath.curve.get_baked_length() / current_virus_speed
	print("Virus starting to move with tween")
	
	$Tween.interpolate_property(
		$BackBufferCopy/VirusMovePath/PathFollow2D,
		"unit_offset", 0, 1, duration)
	$Tween.start()


func _on_VirusCountDownTimer_timeout():
	if can_come and randf() > 0.75: # CHANGE PROBA WITH LEVEL ?
		print("Un virus arrive !")
		can_come = false
		
		"""
const virus_datas: Dictionary = {
	total_proba_weight = 4,
	
	virus_liste = ["pouple", "pirate"],
	poulpe = {
		nominal_speed = 1000,
		proba_weight = 2
	},
	pirate = {
		nominal_speed = 1000,
		proba_weight = 2
	}
}
		"""
		
		var number = randi() % GameData.virus_datas.total_proba_weight + 1
		var p_n = number
		
		for virus in GameData.virus_datas.virus_liste:
			if number <= GameData.virus_datas[virus]["proba_weight"]:
				current_virus_name = virus
				break
			else:
				number -= GameData.virus_datas[virus]["proba_weight"]
		
		print("Virus is : ", current_virus_name, ", number : ", p_n, ", liste : ", GameData.virus_datas.virus_liste)
		current_virus_speed = GameData.virus_datas[current_virus_name]["nominal_speed"]
		print("speed : ", current_virus_speed)
		
		if current_virus_name == "poulpe":
			print("playing poulpe animation")
			$AnimationPlayer.play("RESET")
			$AnimationPlayer.queue("poulpe_discrete_look")
			$BackBufferCopy/VirusMovePath.set_new_curve_poulpe()
		
		elif current_virus_name == "pirate":
			$AnimationPlayer.play("RESET")
			$BackBufferCopy/VirusMovePath.set_new_curve_pirate()
			virus_move_along_curve()
	
	elif can_come:
		print("Virus Not coming")

func _on_Mouse_pressed():
	if is_infested:
		print("Clicked so no longer infected !")
		$AnimationPlayer.play("RESET")
		
		can_come = true
		is_infested = false
		
		match current_virus_name:
			"poulpe":
				var malus = int(5.0*GameData.wealth/6.0)
				GameData.wealth -= malus
				
				computer.popup.set_text(tr("paye_rancon_au_rnasomware_message") % str(malus))
				computer.popup.popup()
			
			"bug":
				TranslationServer.set_locale("fr_CH")


func _on_VirusOutScreenButton_pressed():
	print("Le virus a été écrasé, well done")
	$Tween.stop_all()
	$AnimationPlayer.play("virus_ecrase")

func _on_Computer_exploded():
	$AnimationPlayer.play("RESET")
	$Tween.stop_all()
	can_come = false


func _on_Tween_tween_all_completed():
	print("Un virus a penetre l'ordinateur")
	
	if randf() > GameData.antivirus_proba_tue_virus:
		print("L'ordinateur est infesté (proba : " + str(GameData.antivirus_proba_tue_virus) + ")")
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.queue("take_control_of_computer")
	
	else:
		print("Le virus a été repoussé par l'antivirus (proba : " + str(GameData.antivirus_proba_tue_virus) + ")")
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.queue("antivirus_wins")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "virus_ecrase":
		can_come = true
		$BackBufferCopy/VirusMovePath/PathFollow2D.unit_offset = 0
