extends Node2D

func _ready():
	get_node("/root/ScreenScreamer").register_screen(self)

