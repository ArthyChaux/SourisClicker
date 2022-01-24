extends Node

const SAVE_PATH = "user://datas.cfg"

var config_file = ConfigFile.new()
var datas = {
	wealth = 0,
	increase_on_click = 1,
	mouse_level = 1,
	autoclick_level = 0,
	antivirus_level = 0,
	antivirus_expiration_date = null
}

func load_datas():
	var result = config_file.load(SAVE_PATH)
	
	if not result == OK:
		print("Failed loading datas file. Error code is %s" % result)
		return null
	
	for key in datas.keys(): 
		datas[key] = config_file.get_value("datas", key, datas[key])
	
	print("loaded datas: ", datas)

func save_datas():
	for key in datas.keys():
		config_file.set_value("datas", key, datas[key])
	
	config_file.save(SAVE_PATH)
#	print("saved datas: ", datas)
