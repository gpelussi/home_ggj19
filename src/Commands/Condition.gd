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
	match check_if_player_has_item:
		NO_CHECK:
			pass
		CHECK_TRUE:
			if not inventory.has_item(has_item):
				return finish()
		CHECK_FALSE:
			if inventory.has_item(has_item):
				return finish()
	match check_if_npc_has_item:
		NO_CHECK:
			pass
		CHECK_TRUE:
			if not inventory.npc_has_item(npc_which, npc_which_item):
				return finish()
		CHECK_FALSE:
			if inventory.npc_has_item(npc_which, npc_which_item):
				return finish()
	run_all()