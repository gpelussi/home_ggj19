extends "Command.gd"

const NO_CHECK = 0
const CHECK_TRUE = 1
const CHECK_FALSE = 2

export(int, "no check", "check true", "check false") var check_if_player_has_item = 0
export(String) var has_item = ""

export(int, "no check", "check true", "check false") var check_if_npc_has_item = 0
export(String) var npc_which = ""
export(String) var npc_which_item = ""

func action():
	if check_if_player_has_item > 0:
		if inventory.has_item(has_item):
			print("player has %s!" % has_item)
			if check_if_player_has_item == CHECK_FALSE:
				finish()
				return
		else:
			print("player does not have %s!" % has_item)
			if check_if_player_has_item == CHECK_TRUE:
				finish()
				return
	if check_if_npc_has_item > 0:
		if inventory.npc_has_item(npc_which, npc_which_item):
			if check_if_npc_has_item == CHECK_FALSE:
				finish()
				return
		else:
			if check_if_npc_has_item == CHECK_TRUE:
				finish()
				return