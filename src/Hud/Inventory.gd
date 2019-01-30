extends TextureRect

onready var persistence = get_node("/root/Inventory")
onready var database = get_node("/root/Database")
onready var text_box = get_node("/root/Hud/TextBox")
onready var screen_screamer = get_node("/root/ScreenScreamer")
onready var player_input = get_node("/root/PlayerInput")

func _ready():
	persistence.connect("item_awarded", self, "add_item")
	persistence.connect("item_given", self, "remove_item")
	screen_screamer.connect("set_screen", self, "screen_changed")
	hide()

func update_children_position():
	var idx = 0
	for child in get_children():
		child.position.x = 24 + idx * 32
		child.position.y = 24
		idx += 1

func add_item(item):
	var icon = database.instance_item_icon(item)
	add_child(icon)
	update_children_position()

func remove_item(item):
	if has_node(item):
		var icon = get_node(item)
		icon.queue_free()
	else:
		print("No such item to remove: %s" % item)

func screen_changed():
	show()
