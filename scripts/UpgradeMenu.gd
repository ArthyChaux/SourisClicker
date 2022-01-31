extends Control

var is_shown: bool = false


func show_menu():
	if not is_shown:
		$UpgradeMenuHandle/AnimationPlayer.play("open_upgrade_menu")
		is_shown = true

func hide_menu():
	if is_shown:
		$UpgradeMenuHandle/AnimationPlayer.play_backwards("open_upgrade_menu")
		is_shown = false

func toggle_menu():
	if not $UpgradeMenuHandle/AnimationPlayer.is_playing():
		if is_shown:
			hide_menu()
		else:
			show_menu()

func _on_UpgradeMenuHandle_pressed():
	toggle_menu()
