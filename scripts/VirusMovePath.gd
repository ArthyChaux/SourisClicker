extends Path2D


export(Array, Curve2D) var virus_poulpe_curves

func set_new_curve_poulpe():
	curve = virus_poulpe_curves[randi() % len(virus_poulpe_curves)]
