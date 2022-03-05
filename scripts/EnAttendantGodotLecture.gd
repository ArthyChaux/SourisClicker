extends Panel

export var virus_path: NodePath
onready var virus: Node2D = get_node(virus_path)

func _ready():
	GameData.connect("locale_changed", self, "locale_changed")

func locale_changed(new_locale):
	if new_locale == "fr_FR":
		print("Et maintenant, un peu de lecture")
		virus.is_infested = true
		virus.can_come = false
		
		show()
		$MarginContainer/RichTextLabel.scroll_to_line(0)
