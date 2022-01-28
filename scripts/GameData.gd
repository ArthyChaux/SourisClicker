extends Node

const SAVE_PATH = "user://datas.cfg"

var config_file = ConfigFile.new()
var base_data = {
	wealth = 0,
	increase_on_click = 1,
	heat_loose_factor = 0.02,
	click_per_seconds = 0,
	antivirus_expiration_duration = 0,
	antivirus_proba_tue_virus = 0,
	
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
var datas = base_data

const upgrades_data = {
	mouse = {
		start_price = 150,
		step_price = 50,
		mouses_list = ["base", "triangle"],
		base = {
			unlock_level = 0,
			skin_menu_name = "La basique",
			texture = "res://assets/sprites/souris101.png",
			tex_ture = "res://assets/sprites/souris1.201.png"
		},
		triangle = {
			unlock_level = 10,
			texture = "res://assets/sprites/GrosseSourisTriangle01.png",
			tex_ture = "res://assets/sprites/GrosseSourisTriangle02.png"
		}
	},
	ventil = {
		start_price = 150,
		step_price = 50,
		ventils_list = ["base"],
		base = {
			unlock_level = 0,
			texture = "res://assets/sprites/Ordi01.png"
		}
	},
	autoclick = {
		start_price = 800,
		step_price = 300,
		autoclicks_list = ["hiclick"],
		hiclick = {
			unlock_level = 0,
			texture = "res://assets/sprites/mouse01.png"
		}
	},
	antivirus = {
		start_price = 500,
		step_price = 250,
		antivirus_list = ["abast"],
		abast = {
			unlock_level = 0,
			texture = "res://assets/sprites/VirusPoulpe01.png"
		}
	},
	table = {
		start_price = 2500,
		step_price = 5000,
		table_list = ["bois"],
		bois = {
			unlock_level = 0,
			texture = "res://assets/texture/70-707718_saturated-oak-texture-oak-wood-texture.jpg"
		}
	}
}

signal _data_loaded()

func load_datas():
	var result = config_file.load(SAVE_PATH)
	
	if not result == OK:
		print("Failed loading datas file. Error code is %s" % result)
		return null
	
	for key in datas.keys(): 
		datas[key] = config_file.get_value("datas", key, datas[key])
	
	print("loaded datas: ", datas)
	emit_signal("_data_loaded")

#Save with timer for not oversaving ?
func soft_save_datas():
	for key in datas.keys():
		config_file.set_value("datas", key, datas[key])
	
	config_file.save(SAVE_PATH)

func save_datas():
	for key in datas.keys():
		config_file.set_value("datas", key, datas[key])
	
	config_file.save(SAVE_PATH)
