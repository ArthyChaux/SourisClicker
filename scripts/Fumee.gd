extends Node2D


var lifetime: float = 5


func _ready():
	$Sprite/Tween.interpolate_property($Sprite, "position", Vector2(0, 0), Vector2(0, -150), lifetime)
	$Sprite/Tween.interpolate_property($Sprite, "modulate", Color(1, 1, 1, 1), Color(1, 1, 1, 0), lifetime, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Sprite/Tween.interpolate_property($Sprite, "self_modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), lifetime, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Sprite/Tween.start()
