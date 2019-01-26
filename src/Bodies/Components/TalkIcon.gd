extends Sprite

onready var interaction = get_node("../Interaction")

func _ready():
	hide()
	interaction.connect("set_target", self, "show")
	interaction.connect("unset_target", self, "hide")
