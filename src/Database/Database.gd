extends Node2D

func item_exists(item):
	return has_node(item)

func instance_item_icon(item):
	assert(item_exists(item))
	var icon_sprite = get_node(item)
	return icon_sprite.duplicate()
