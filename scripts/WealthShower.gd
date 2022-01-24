extends Label


func _on_Racine_wealth_changed(new_wealth):
	text = str(new_wealth) + "C"
