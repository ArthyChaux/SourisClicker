extends TextureButton


var wikipedia_pages = [
	["https://en.wikipedia.org/wiki/Recursive_islands_and_lakes", "Recursive islands and lakes"],
	["https://fr.wikipedia.org/wiki/Jean_(tissu)", "Jean"],
	["https://fr.wikipedia.org/wiki/Zeppelin", "Zeppelin"]
]

var current_url: String
var current_article_name: String


func _ready():
	set_timer()

func set_timer():
	$Timer.start(rand_range(60, 500))


func select_new_article():
	var couple = wikipedia_pages[randi() % len(wikipedia_pages)]
	
	current_url = couple[0]
	current_article_name = couple[1]
	
	$Label.text = current_article_name


func _on_Butterfly_pressed():
	OS.shell_open(current_url)


func _on_Timer_timeout():
	select_new_article()
	$AnimationPlayer.play("pass_by_screen")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "pass_by_screen":
		set_timer()
