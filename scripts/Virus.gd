extends Node2D

onready var computer = get_parent()

var is_infested: bool = false
var can_come: bool = true

var virus_speed = 1200

func virus_move():
	var duration = $BackBufferCopy/VirusMovePath.curve.get_baked_length() / virus_speed
	print("Virus starting to move with tween, taking ", duration, "s")
	
	$Tween.interpolate_property(
		$BackBufferCopy/VirusMovePath/PathFollow2D,
		"unit_offset", 0, 1, duration)
	$Tween.start()


func _on_VirusCountDownTimer_timeout():
	if not is_infested and can_come and randf() > 0.75:
		print("Un virus arrive !")
		can_come = false
		
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("go_in_disc")
		$BackBufferCopy/VirusMovePath.set_new_curve()
	
	elif not is_infested and can_come:
		print("Virus Not coming")

func _on_Mouse_pressed():
	if is_infested:
		$AnimationPlayer.play("RESET")
		
		can_come = true
		
		if randf() > 0.5:
			print("Wealth initial : ", GameData.wealth)
			
			var malus = int(5.0*GameData.wealth/6.0)
			print("Malus : ", malus)
			GameData.wealth -= malus
			
			print(tr("paye_rancon_au_rnasomware_message"))
			computer.popup.set_text(tr("paye_rancon_au_rnasomware_message") % str(malus))
			computer.popup.popup()
			
			print("Tu t'es libéré du virus, et a payé ta rancon de  " + str(malus) + "C au ransomware")
			
			is_infested = false
		
		else:
			TranslationServer.set_locale("fr_CH")
			
			is_infested = false


func _on_VirusOutScreenButton_pressed():
	print("Le virus a été écrasé, well done")
	$Tween.stop_all()
	$AnimationPlayer.play("virus_ecrase")

func _on_Computer_exploded():
	$AnimationPlayer.play("RESET")
	can_come = false


func _on_Tween_tween_all_completed():
	print("Un virus a penetre l'ordinateur")
	
	if randf() > GameData.antivirus_proba_tue_virus:
		print("L'ordinateur est infesté (proba : " + str(GameData.antivirus_proba_tue_virus) + ")")
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("take_control_of_computer")
		is_infested = true
	
	else:
		print("Le virus a été repoussé par l'antivirus (proba : " + str(GameData.antivirus_proba_tue_virus) + ")")
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("antivirus_wins")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "virus_ecrase":
		can_come = true
