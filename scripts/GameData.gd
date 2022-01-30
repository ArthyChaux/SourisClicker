extends Node

const SAVE_PATH = "user://datas.cfg"

var can_save_data : bool = true

#### DATAS ####

var config_file = ConfigFile.new()
const base_data = {
	wealth = 0,
	
	# - Not necessary, will be removed
	increase_on_click = 1,
	heat_loose_factor = 0.02,
	heat_increase_on_click = 0.02,
	click_per_seconds = 0,
	antivirus_expiration_duration = 0,
	antivirus_proba_tue_virus = 0,
	# -
	
	mouse_level = 1,
	ventil_level = 1,
	autoclick_level = 0,
	antivirus_level = 0,
	table_level = 0,
	
	mouse_skin = "base",
	ventil_skin = "base",
	autoclick_skin = "hiclick",
	antivirus_skin = "abast",
	table_skin = "bois"
}
var datas = base_data.duplicate()

const upgrades_data = {
	mouse = {
		start_price = 150,
		step_price = 50,
		max_upgrade_level = 9223372036854775807,
		
		mouses_list = [
			"base", "triangle", "blanche", "mieux", "amongus",
			"coccinelle", "gamerblue", "gamercyan", "gamergreen",
			"gamerorange", "gamerpink", "gamerred", "gamerviolet",
			"gamerwhite", "gameryell"
		],
		base = {
			unlock_level = 0,
			skin_menu_name = "base_mouse_desc",
			texture = "res://assets/sprites/souris101.png",
			tex_ture = "res://assets/sprites/souris1.201.png"
		},
		triangle = {
			unlock_level = 10,
			skin_menu_name = "triangle_mouse_desc",
			texture = "res://assets/sprites/GrosseSourisTriangle01.png",
			tex_ture = "res://assets/sprites/GrosseSourisTriangle02.png"
		},
		blanche = {
			unlock_level = 20,
			skin_menu_name = "blanche_mouse_desc",
			texture = "res://assets/sprites/SourisBlanche02.png",
			tex_ture = "res://assets/sprites/SourisBlanche01.png"
		},
		mieux = {
			unlock_level = 30,
			skin_menu_name = "mieux_mouse_desc",
			texture = "res://assets/sprites/SourisMieux01.png",
			tex_ture = "res://assets/sprites/SourisMieux02.png"
		},
		amongus = {
			unlock_level = 40,
			skin_menu_name = "amongus_mouse_desc",
			texture = "res://assets/sprites/VirusPoulpe01.png",
			tex_ture = "res://assets/sprites/VirusPoulpe02.png"
		},
		coccinelle = {
			unlock_level = 50,
			skin_menu_name = "coccinelle_mouse_desc",
			texture = "res://assets/sprites/thermometre_progress_bayer.png",
			tex_ture = "res://assets/sprites/thermometre_progress_gradient.png"
		},
		gamerblue = {
			unlock_level = 60,
			skin_menu_name = "gamerblue_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_blue01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_blue02.png"
		},
		gamercyan = {
			unlock_level = 70,
			skin_menu_name = "gamercyan_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_cyan01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_cyan02.png"
		},
		gamergreen = {
			unlock_level = 80,
			skin_menu_name = "gamergreen_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_green01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_green02.png"
		},
		gamerorange = {
			unlock_level = 90,
			skin_menu_name = "gamerorange_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_orange01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_orange02.png"
		},
		gamerpink = {
			unlock_level = 100,
			skin_menu_name = "gamerpink_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_pink01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_pink02.png"
		},
		gamerred = {
			unlock_level = 110,
			skin_menu_name = "gamerred_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_red01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_red02.png"
		},
		gamerviolet = {
			unlock_level = 120,
			skin_menu_name = "gamerviolet_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_violet01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_violet02.png"
		},
		gamerwhite = {
			unlock_level = 130,
			skin_menu_name = "gamerwhite_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_white01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_white02.png"
		},
		gameryell = {
			unlock_level = 140,
			skin_menu_name = "gameryell_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_yell01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_yell02.png"
		}
	},
	ventil = {
		start_price = 150,
		step_price = 50,
		max_upgrade_level = 9223372036854775807,
		
		ventils_list = ["base"],
		base = {
			unlock_level = 0,
			skin_menu_name = "base_computer_desc",
			texture = "res://assets/sprites/Ordi01.png"
		}
	},
	autoclick = {
		start_price = 800,
		step_price = 300,
		max_upgrade_level = 9223372036854775807,
		
		autoclicks_list = ["hiclick"],
		hiclick = {
			unlock_level = 0,
			texture = "res://assets/sprites/mouse01.png"
		}
	},
	antivirus = {
		start_price = 500,
		step_price = 250,
		max_upgrade_level = 9223372036854775807,
		
		antivirus_list = ["abast"],
		abast = {
			unlock_level = 0,
			texture = "res://assets/sprites/VirusPoulpe01.png"
		}
	},
	table = {
		start_price = 2500,
		step_price = 5000,
		max_upgrade_level = 0,
		
		table_list = ["bois"],
		bois = {
			unlock_level = 0,
			skin_menu_name = "table_bois_desc",
			texture = "res://assets/texture/70-707718_saturated-oak-texture-oak-wood-texture.jpg"
		}
	}
}

#### SAVING / LOADING FUNCS ####

func _ready():
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5
	timer.connect("timeout", self, "save_datas")
	timer.start()

signal _data_loaded()

func load_datas():
	var result = config_file.load(SAVE_PATH)
	
	if not result == OK:
		print("Failed loading datas file. Error code is %s" % result)
		return null
	
	for key in datas.keys(): 
		datas[key] = config_file.get_value("datas", key, datas[key])
	
	print("loaded datas: ", JSON.print(datas, "\t"))
	emit_signal("_data_loaded")

func save_datas(other_datas = null, force_saving = false):
	if can_save_data or force_saving:
		if other_datas == null:
			for key in datas.keys():
				config_file.set_value("datas", key, datas[key])
		
		else:
			for key in other_datas.keys():
				config_file.set_value("datas", key, other_datas[key])
		
		config_file.save(SAVE_PATH)
