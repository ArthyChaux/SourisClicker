extends Path2D


export(Array, Curve2D) var virus_poulpe_curves
export(Array, Curve2D) var virus_pirate_curves
export(Array, Curve2D) var virus_bug_curves
export(Array, Curve2D) var virus_spider_curves
export(Array, Curve2D) var virus_eve_curves

func set_new_curve_poulpe():
	curve = virus_poulpe_curves[randi() % len(virus_poulpe_curves)]

func set_new_curve_pirate():
	curve = virus_pirate_curves[randi() % len(virus_pirate_curves)]

func set_new_curve_bug():
	curve = virus_bug_curves[randi() % len(virus_bug_curves)]

func set_new_curve_spider():
	curve = virus_spider_curves[randi() % len(virus_spider_curves)]

func set_new_curve_eve():
	curve = virus_eve_curves[randi() % len(virus_eve_curves)]
