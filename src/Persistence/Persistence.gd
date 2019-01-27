extends Node

const FILENAME_PATH = "user://%s.data"

export(String) var persistance_name = "userdata"

var data = {}

func set_data(field, value):
	data[field] = value

func get_data(field, default = null):
	if not data.has(field):
		return default
	return data[field]

func save_data():
	var filepath = FILENAME_PATH % persistance_name
	var file = File.new()
	file.open(filepath, File.WRITE)
	var savedata = JSON.print(data, "  ", true)
	file.store_string(savedata)
	file.close()

func load_data():
	var filepath = FILENAME_PATH % persistance_name
	var file = File.new()
	if file.file_exists(filepath):
		file.open(filepath, File.READ)
		var json_raw = file.get_as_text()
		file.close()
		data = JSON.parse(json_raw).result
