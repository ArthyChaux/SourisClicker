extends Node2D

onready var computer = get_parent()

var is_infested: bool = false


func _on_VirusCountDownTimer_timeout():
	if not is_infested and not $AnimationPlayer.is_playing() and randf() > 0.75:
		print("Un virus arrive !")
		$AnimationPlayer.play("RESET")
		$AnimationPlayer.play("go_in_disc")
	
	elif not is_infested and not $AnimationPlayer.is_playing():
		print("Virus Not coming")

func _on_Mouse_pressed():
	if is_infested:
		$AnimationPlayer.play("RESET")
		
		
		if randf() > 0.5:
			print("Wealth initial : ", computer.racine.wealth)
			
			var malus = int(5*computer.racine.wealth/6)
			print("Malus : ", malus)
			computer.racine.wealth -= malus
			
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
	$AnimationPlayer.play("virus_ecrase")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "go_in_disc":
		print("Un virus a penetre l'ordinateur")
		
		if randf() > computer.antivirus_proba_tue_virus:
			print("L'ordinateur est infesté (proba : " + str(computer.antivirus_proba_tue_virus) + ")")
			$AnimationPlayer.play("RESET")
			$AnimationPlayer.play("take_control_of_computer")
			is_infested = true
		
		else:
			print("Le virus a été repoussé par l'antivirus (proba : " + str(computer.antivirus_proba_tue_virus) + ")")
			$AnimationPlayer.play("RESET")
			$AnimationPlayer.play("antivirus_wins")
