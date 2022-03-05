extends PanelContainer


var first: int
var second: int


export var virus_path: NodePath
onready var virus: Node2D = get_node(virus_path)


func popup():
	first = randi() % 500000000000
	second = randi() % 500000000000
	
	$MarginContainer/VBoxContainer/HBoxContainer/Label.text = str(first) + " + " + str(second) + " = "
	$MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text = ""
	
	$AnimationPlayer.play("show_popup")


func _on_DismissPopupButton_pressed():
	if $MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text.is_valid_integer() && $MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text != "":
		$AnimationPlayer.play_backwards("show_popup")
		
		if int($MarginContainer/VBoxContainer/HBoxContainer/LineEdit.text) == first + second:
			get_parent().get_parent().get_node("PopupExclusive/Popup").set_text("Tu as été détecté comme : robot. Tes clicks ne sont donc pas comptabilisés comme valides.")
			get_parent().get_parent().get_node("PopupExclusive/Popup").popup()
			
			GameData.wealth = 0
		
		else:
			get_parent().get_parent().get_node("PopupExclusive/Popup").set_text("Tu as été détecté comme : humain.")
			get_parent().get_parent().get_node("PopupExclusive/Popup").popup()
		
		virus.can_come = true
		virus.is_infested = false
