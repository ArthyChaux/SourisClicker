extends TextureRect

var is_down: bool = false


func _ready():
	set_canne_timer()


func set_canne_timer():
	#Finale 600 - 3600
	$Timer.start(rand_range(45, 240))

func set_canne_up_timer():
	$Timer.start(10)


func _on_CanneButton_pressed():
	if GameData.locale == "en" or GameData.locale == "ja" or GameData.locale == "it":
		OS.shell_open("https://en.wikipedia.org/wiki/Phishing")
	else:
		OS.shell_open("https://fr.wikipedia.org/wiki/Hame%C3%A7onnage")
	
	$AnimationPlayer.play_backwards("canne_descends")

func _on_AnimationPlayer_animation_finished(_anim_name):
	if is_down:
		set_canne_timer()
		is_down = false
	
	else:
		set_canne_up_timer()
		is_down = true


func _on_Timer_timeout():
	if is_down:
		$AnimationPlayer.play_backwards("canne_descends")
	
	else:
		$AnimationPlayer.play("canne_descends")
