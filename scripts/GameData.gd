extends Node


# Aller à la ligne -> Ctrl + L
# DATAS : 32
# DERIVED DATAS : 192
# SAVING : 259
# CONST DATAS : 310
# UPGRADE DATAS : 350


var can_save_data: bool = true

#### MEMBERS ####

func _ready():
	var timer: Timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5
	timer.connect("timeout", self, "save_datas")
	timer.start()

###############
#### DATAS ####
#### DATAS ####
#### DATAS ####
#### DATAS ####
#### DATAS ####
#### DATAS ####
#### DATAS ####
#### DATAS ####
###############

# WEALTH #
signal wealth_changed(new_wealth)
var wealth: int = 0 setget set_wealth

func set_wealth(new_wealth: int):
	wealth = new_wealth
	emit_signal("wealth_changed", new_wealth)

# MOUSE LEVEL #
signal mouse_level_changed(new_mouse_level)
var mouse_level: int = 1 setget set_mouse_level

func set_mouse_level(new_mouse_level: int):
	mouse_level = new_mouse_level
	emit_signal("mouse_level_changed", new_mouse_level)
	save_datas()

# VENTIL LEVEL #
signal ventil_level_changed(new_ventil_level)
var ventil_level: int = 1 setget set_ventil_level

func set_ventil_level(new_ventil_level: int):
	ventil_level = new_ventil_level
	emit_signal("ventil_level_changed", new_ventil_level)
	save_datas()

# AUTOCLICK LEVEL #
signal autoclick_level_changed(new_autoclick_level)
var autoclick_level: int = 0 setget set_autoclick_level

func set_autoclick_level(new_autoclick_level: int):
	autoclick_level = new_autoclick_level
	emit_signal("autoclick_level_changed", new_autoclick_level)
	save_datas()

# ANTIVIRUS LEVEL #
signal antivirus_level_changed(new_antivirus_level)
var antivirus_level: int = 0 setget set_antivirus_level

func set_antivirus_level(new_antivirus_level: int):
	antivirus_level = new_antivirus_level
	emit_signal("antivirus_level_changed", new_antivirus_level)
	save_datas()

# ANTIVIRUS LEVEL #
signal antivirus_duration_changed(new_antivirus_duration)
var antivirus_duration: int = 0 setget set_antivirus_duration

func set_antivirus_duration(new_antivirus_duration: int):
	if new_antivirus_duration <= 0:
		antivirus_level = 0
		new_antivirus_duration = 0
	
	antivirus_duration = new_antivirus_duration
	emit_signal("antivirus_duration_changed", new_antivirus_duration)

# TABLE LEVEL #
signal table_level_changed(new_table_level)
var table_level: int = 1 setget set_table_level

func set_table_level(new_table_level: int):
	table_level = new_table_level
	emit_signal("table_level_changed", new_table_level)
	save_datas()

# MOUSE SKIN #
signal mouse_skin_changed(new_mouse_skin)
var mouse_skin: String = "base" setget set_mouse_skin

func set_mouse_skin(new_mouse_skin: String):
	mouse_skin = new_mouse_skin
	emit_signal("mouse_skin_changed", new_mouse_skin)
	save_datas()

# VENTIL SKIN #
signal ventil_skin_changed(new_ventil_skin)
var ventil_skin: String = "base" setget set_ventil_skin

func set_ventil_skin(new_ventil_skin: String):
	ventil_skin = new_ventil_skin
	emit_signal("ventil_skin_changed", new_ventil_skin)
	save_datas()

# AUTOCLICK SKIN #
signal autoclick_skin_changed(new_autoclick_skin)
var autoclick_skin: String = "hiclick" setget set_autoclick_skin

func set_autoclick_skin(new_autoclick_skin: String):
	autoclick_skin = new_autoclick_skin
	emit_signal("autoclick_skin_changed", new_autoclick_skin)
	save_datas()

# ANTIVIRUS SKIN #
signal antivirus_skin_changed(new_antivirus_skin)
var antivirus_skin: String = "abast" setget set_antivirus_skin

func set_antivirus_skin(new_antivirus_skin: String):
	antivirus_skin = new_antivirus_skin
	emit_signal("antivirus_skin_changed", new_antivirus_skin)
	save_datas()

# TABLE SKIN #
signal table_skin_changed(new_table_skin)
var table_skin: String = "bois" setget set_table_skin

func set_table_skin(new_table_skin: String):
	table_skin = new_table_skin
	emit_signal("table_skin_changed", new_table_skin)
	save_datas()

#### DATAS ####

var datas: Dictionary setget set_datas, get_datas

func set_datas(new_datas: Dictionary):
	self.wealth = new_datas["wealth"]
	
	self.mouse_level = new_datas["mouse_level"]
	self.ventil_level = new_datas["ventil_level"]
	self.autoclick_level = new_datas["autoclick_level"]
	self.antivirus_level = new_datas["antivirus_level"]
	self.table_level = new_datas["table_level"]
	
	self.mouse_skin = new_datas["mouse_skin"]
	self.ventil_skin = new_datas["ventil_skin"]
	self.autoclick_skin = new_datas["autoclick_skin"]
	self.antivirus_skin = new_datas["antivirus_skin"]
	self.table_skin = new_datas["table_skin"]

func get_datas() -> Dictionary:
	return {
		"wealth": wealth,
		
		"mouse_level": mouse_level,
		"ventil_level": ventil_level,
		"autoclick_level": autoclick_level,
		"antivirus_level": antivirus_level,
		"table_level": table_level,
		
		"mouse_skin": mouse_skin,
		"ventil_skin": ventil_skin,
		"autoclick_skin": autoclick_skin,
		"antivirus_skin": antivirus_skin,
		"table_skin": table_skin
	}


#######################
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#### DERIVED DATAS ####
#######################

# WEALTH INCREASE ON CLICK #
var wealth_increase_on_click: int setget , get_wealth_increase_on_click

func get_wealth_increase_on_click():
	return mouse_level * mouse_level

# HEAT INCREASE ON CLICK #
var heat_increase_on_click: float setget , get_heat_increase_on_click

func get_heat_increase_on_click():
	return 0.5 * pow(float(ventil_level), -2)

# CLICKS PER SECONDS #
var clicks_per_seconds: int setget , get_clicks_per_seconds

func get_clicks_per_seconds():
	return autoclick_level * autoclick_level

# ANTIVIRUS PROBA TUER VIRUS #
var antivirus_proba_tue_virus: float setget , get_antivirus_proba_tue_virus

func get_antivirus_proba_tue_virus():
	return atan(antivirus_level)/(PI/2)

# MOUSE UPGRADE PRICE #
var mouse_upgrade_price: int setget , get_mouse_upgrade_price

func get_mouse_upgrade_price():
	return 150 + mouse_level*mouse_level * 50

# VENTIL UPGRADE PRICE #
var ventil_upgrade_price: int setget , get_ventil_upgrade_price

func get_ventil_upgrade_price():
	return 150 + ventil_level*ventil_level * 50

# AUTOCLICK UPGRADE PRICE #
var autoclick_upgrade_price: int setget , get_autoclick_upgrade_price

func get_autoclick_upgrade_price():
	return 500 + autoclick_level*autoclick_level * 150

# ANTIVIRUS UPGRADE PRICE #
var antivirus_upgrade_price: int setget , get_antivirus_upgrade_price

func get_antivirus_upgrade_price():
	return 500 + antivirus_level*antivirus_level * 250

# TABLE UPGRADE PRICE #
var table_upgrade_price: int setget , get_table_upgrade_price

func get_table_upgrade_price():
	return 2500 + table_level*table_level * 5000

################################
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
#### SAVING / LOADING FUNCS ####
################################

signal _data_loaded()

func load_datas():
	var result = config_file.load(SAVE_PATH)
	
	if not result == OK:
		printerr("Failed loading datas file. Error code is %s" % result)
		return null
	
	var loaded_datas: Dictionary = base_data.duplicate()
	
	for key in loaded_datas.keys(): 
		loaded_datas[key] = config_file.get_value("datas", key, loaded_datas[key])
	
	set_datas(loaded_datas)
	
	print("loaded datas: ", JSON.print(self.datas, "\t"))
	emit_signal("_data_loaded")

func save_datas(other_datas = null, force_saving = false):
	if can_save_data or force_saving:
		if other_datas == null:
			var save_datas = self.datas
			
			for key in save_datas.keys():
				config_file.set_value("datas", key, save_datas[key])
		
		else:
			for key in other_datas.keys():
				config_file.set_value("datas", key, other_datas[key])
		
		config_file.save(SAVE_PATH)
		

#####################
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#### CONST DATAS ####
#####################

const SAVE_PATH = "user://datas.cfg"

var config_file = ConfigFile.new()
const base_data = {
	wealth = 0,
	
	mouse_level = 1,
	ventil_level = 1,
	autoclick_level = 0,
	antivirus_level = 0,
	table_level = 1,
	
	mouse_skin = "base",
	ventil_skin = "base",
	autoclick_skin = "hiclick",
	antivirus_skin = "abast",
	table_skin = "bois"
}

const upgrades_data = {
	mouse = {
		max_upgrade_level = 9223372036854775807,
		
		mouses_list = [
			"base", "triangle", "blanche", "mieux", "amongus",
			"coccinelle", "gamerblue", "gamercyan", "gamergreen",
			"gamerorange", "gamerpink", "gamerred", "gamerviolet",
			"gamerwhite", "gameryell"
		],
		base = {
			unlock_level = 0,
			unlock_message = "mouse_base_upgrade_message",
			skin_menu_name = "base_mouse_desc",
			texture = "res://assets/sprites/souris101.png",
			tex_ture = "res://assets/sprites/souris1.201.png"
		},
		triangle = {
			unlock_level = 10,
			unlock_message = "mouse_triangle_upgrade_message",
			skin_menu_name = "triangle_mouse_desc",
			texture = "res://assets/sprites/GrosseSourisTriangle01.png",
			tex_ture = "res://assets/sprites/GrosseSourisTriangle02.png"
		},
		blanche = {
			unlock_level = 20,
			unlock_message = "mouse_blanche_upgrade_message",
			skin_menu_name = "blanche_mouse_desc",
			texture = "res://assets/sprites/SourisBlanche02.png",
			tex_ture = "res://assets/sprites/SourisBlanche01.png"
		},
		mieux = {
			unlock_level = 30,
			unlock_message = "mouse_mieux_upgrade_message",
			skin_menu_name = "mieux_mouse_desc",
			texture = "res://assets/sprites/SourisMieux01.png",
			tex_ture = "res://assets/sprites/SourisMieux02.png"
		},
		amongus = {
			unlock_level = 40,
			unlock_message = "mouse_amongus_upgrade_message",
			skin_menu_name = "amongus_mouse_desc",
			texture = "res://assets/sprites/VirusPoulpe01.png",
			tex_ture = "res://assets/sprites/VirusPoulpe02.png"
		},
		coccinelle = {
			unlock_level = 50,
			unlock_message = "mouse_coccinelle_upgrade_message",
			skin_menu_name = "coccinelle_mouse_desc",
			texture = "res://assets/sprites/thermometre_progress_bayer.png",
			tex_ture = "res://assets/sprites/thermometre_progress_gradient.png"
		},
		gamerblue = {
			unlock_level = 60,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_blue",
			skin_menu_name = "gamerblue_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_blue01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_blue02.png"
		},
		gamercyan = {
			unlock_level = 70,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_cyan",
			skin_menu_name = "gamercyan_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_cyan01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_cyan02.png"
		},
		gamergreen = {
			unlock_level = 80,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_green",
			skin_menu_name = "gamergreen_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_green01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_green02.png"
		},
		gamerorange = {
			unlock_level = 90,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_orange",
			skin_menu_name = "gamerorange_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_orange01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_orange02.png"
		},
		gamerpink = {
			unlock_level = 100,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_pink",
			skin_menu_name = "gamerpink_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_pink01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_pink02.png"
		},
		gamerred = {
			unlock_level = 110,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_red",
			skin_menu_name = "gamerred_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_red01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_red02.png"
		},
		gamerviolet = {
			unlock_level = 120,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_violet",
			skin_menu_name = "gamerviolet_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_violet01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_violet02.png"
		},
		gamerwhite = {
			unlock_level = 130,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_white",
			skin_menu_name = "gamerwhite_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_white01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_white02.png"
		},
		gameryell = {
			unlock_level = 140,
			unlock_message = "mouse_gamer_upgrade_message",
			gamer_mouse_color = "color_yellow",
			skin_menu_name = "gameryell_mouse_desc",
			texture = "res://assets/sprites/souris_gamer/souris_gamer_yell01.png",
			tex_ture = "res://assets/sprites/souris_gamer/souris_gamer_yell02.png"
		}
	},
	ventil = {
		max_upgrade_level = 9223372036854775807,
		
		ventils_list = ["base"],
		base = {
			unlock_level = 0,
			unlock_message = "ventil_base_upgrade_message",
			skin_menu_name = "base_computer_desc",
			texture = "res://assets/sprites/Ordi01.png"
		}
	},
	autoclick = {
		max_upgrade_level = 9223372036854775807,
		
		autoclicks_list = ["hiclick"],
		hiclick = {
			unlock_level = 1,
			unlock_message = "hiclick_upgrade_message",
			skin_menu_name = "hiclick_desc",
			texture = "res://assets/sprites/mouse01.png"
		}
	},
	antivirus = {
		max_upgrade_level = 9223372036854775807,
		
		antivirus_list = ["abast"],
		abast = {
			unlock_level = 1,
			unlock_message = "abast_upgrade_message",
			texture = "res://assets/sprites/VirusPoulpe01.png"
		}
	},
	table = {
		max_upgrade_level = 1,
		
		table_list = ["bois"],
		bois = {
			unlock_level = 1,
			unlock_message = "table_bois_upgrade_message",
			skin_menu_name = "table_bois_desc",
			texture = "res://assets/texture/70-707718_saturated-oak-texture-oak-wood-texture.jpg"
		}
	}
}
