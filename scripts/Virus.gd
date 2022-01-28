extends Node2D

onready var computer = get_parent()

var is_infested: bool = false

func _ready():
	$AnimationPlayer.play("go_in_disc")

func _on_VirusCountDownTimer_timeout():
	print("Un virus arrive !")
	$AnimationPlayer.play("go_in_disc")


func _on_Mouse_pressed():
	if is_infested:
		$AnimationPlayer.play("RESET")
		
		var malus = int(computer.racine.wealth/10)
		computer.racine.wealth = malus
		
		computer.popup.set_text("Tu as paye ta rancon de " + str(malus) + "C au ransomware")
		computer.popup.popup()
		
		print("Tu t'es libéré du virus, et a payé ta rancon de  " + str(malus) + "C au ransomware")
		
		is_infested = false


func _on_VirusOutScreenButton_pressed():
	print("Le virus a été écrasé")
	$AnimationPlayer.play("RESET")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "go_in_disc":
		print("Un virus a penetre l'ordinateur")
		if randf() > computer.antivirus_proba_tue_virus:
			print("L'ordinateur est infesté")
			$AnimationPlayer.play("take_control_of_computer")
			is_infested = true
		
		else:
			print("Le virus a été repoussé par l'antivirus (proba : " + str(computer.antivirus_proba_tue_virus) + ")")
			$AnimationPlayer.play("antivirus_wins")
