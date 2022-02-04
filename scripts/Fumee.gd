extends Node2D


var speed = 30
onready var computer = get_parent().get_parent()

func _ready():
	yield(get_tree().create_timer(rand_range(0, 12)), "timeout")
	
	pop()

func pop():
	var duration = computer.fumee_lifetime_profile.interpolate_baked(0.01 * computer.heat - 0.2) + randf()
	
	var dist = speed * duration * rand_range(0.9, 1.1)
	var max_opacity = 1 - atan(0.1*duration) * 2/PI
	var offset = Vector2(rand_range(-11, 11), rand_range(-11, 11))
	
	$Tween.interpolate_property(self, "position", offset, offset + Vector2(0, -dist), duration, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.interpolate_property(self, "self_modulate", Color(1, 1, 1, max_opacity), Color(1, 1, 1, 0), duration, Tween.TRANS_CUBIC, Tween.EASE_IN)
	$Tween.interpolate_property(self, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, max_opacity), duration, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	$Tween.interpolate_property(self, "frame", 0, 12, duration)
	$Tween.start()

func _on_Tween_tween_all_completed():
	pop()
