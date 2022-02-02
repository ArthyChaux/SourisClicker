extends Path2D


export(Array, Curve2D) var curves

func set_new_curve():
	curve = curves[randi() % len(curves)]
