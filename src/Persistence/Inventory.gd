extends "res://Persistence/Persistence.gd"

const GIVEN_STRING = "%s_was_given_to"

func gain_item(item):
	set_data(item, true)

func has_item(item):
	return get_data(item)

func give_item_to(item, to):
	set_data(GIVEN_STRING % item, to)
	
func gave_item_to(item, to):
	return get_data(GIVEN_STRING % item) == to
