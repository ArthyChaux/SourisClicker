extends Node2D


export var popup_path: NodePath
onready var popup: PanelContainer = get_node(popup_path)


onready var computer = get_parent()

export var is_infested: bool = false
export var can_come: bool = true


var current_virus_name: String
var current_virus_speed: int


func virus_move_along_curve():
	var duration = $BackBufferCopy/VirusMovePath.curve.get_baked_length() / current_virus_speed
	print("Virus starting to move with tween")
	
	$BackBufferCopy/MaskVirusOutPolygon.show()
	$BackBufferCopy/MaskVirusInPolygon.hide()
	
	$Tween.interpolate_property(
		$BackBufferCopy/VirusMovePath/PathFollow2D,
		"unit_offset", 0, 1, duration)
	$Tween.start()


func _on_VirusCountDownTimer_timeout():
	if can_come and randf() > 0.75: # CHANGE PROBA WITH LEVEL ?
		print("Un virus arrive !")
		can_come = false
		
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
		
		$BackBufferCopy/MaskVirusOutPolygon.show()
		$BackBufferCopy/MaskVirusInPolygon.hide()
		
		match current_virus_name:
			"poulpe":
				print("playing poulpe animation")
				$AnimationPlayer.play("poulpe_discrete_look")
				$BackBufferCopy/VirusMovePath.set_new_curve_poulpe()
				
				$BackBufferCopy/VirusMovePath/PathFollow2D/pirate.hide()
				$BackBufferCopy/VirusMovePath/PathFollow2D/poulpe.show()
				$BackBufferCopy/VirusMovePath/PathFollow2D/bug.hide()
		
			"pirate":
				$BackBufferCopy/VirusMovePath.set_new_curve_pirate()
				
				$BackBufferCopy/VirusMovePath/PathFollow2D/poulpe.hide()
				$BackBufferCopy/VirusMovePath/PathFollow2D/pirate.show()
				$BackBufferCopy/VirusMovePath/PathFollow2D/bug.hide()
				virus_move_along_curve()
			
			"bug":
				$BackBufferCopy/VirusMovePath.set_new_curve_bug()
				
				$BackBufferCopy/VirusMovePath/PathFollow2D/poulpe.hide()
				$BackBufferCopy/VirusMovePath/PathFollow2D/pirate.hide()
				$BackBufferCopy/VirusMovePath/PathFollow2D/bug.show()
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


func _on_VirusOutScreenButton_pressed():
	print("Le virus a été écrasé, well done")
	$Tween.remove_all()
	$AnimationPlayer.play("virus_ecrase")

func _on_Computer_exploded():
	$AnimationPlayer.play("RESET")
	$Tween.remove_all()
	can_come = false



func _on_Tween_tween_all_completed():
	print("Un virus a penetre l'ordinateur")
	
	if randf() > GameData.antivirus_proba_tue_virus:
		print("Le virus est passé (proba : " + str(GameData.antivirus_proba_tue_virus) + ")")
		
		match current_virus_name:
			"poulpe":
				$AnimationPlayer.play("poulpe_take_control_of_computer")
			
			"pirate":
				$AnimationPlayer.play("pirate_passed_antivirus")
			
			"bug":
				can_come = true
				TranslationServer.set_locale("fr_CH" if randi() % 1 == 0 else "ja")
	
	else:
		print("Le virus a été repoussé par l'antivirus (proba : " + str(GameData.antivirus_proba_tue_virus) + ")")
		
		$AnimationPlayer.play("antivirus_wins")
	


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "virus_ecrase":
		can_come = true
		$BackBufferCopy/VirusMovePath/PathFollow2D.unit_offset = 0
	
	elif anim_name == "pirate_passed_antivirus":
		var vol = 5
		
		GameData.mouse_level = max(GameData.mouse_level-5, 1)
		
		popup.set_text(tr("pirate_vol_souris_message") % vol)
		popup.popup()
		
		can_come = true
