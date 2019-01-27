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
	print("check_if_player_has_item", check_if_player_has_item)
	if check_if_player_has_item > 0:
		if inventory.has_item(has_item):
			if check_if_player_has_item == CHECK_FALSE:
				run_recursive = false
				emit_signal("command_done")
				print("condition failed: player has item")
				return
		else:
			if check_if_player_has_item == CHECK_TRUE:
				run_recursive = false
				emit_signal("command_done")
				print("condition failed: player does not have item")
				return
	if check_if_npc_has_item > 0:
		if inventory.npc_has_item(npc_which, npc_which_item):
			if check_if_npc_has_item == CHECK_FALSE:
				run_recursive = false
				emit_signal("command_done")
				print("condition failed: npc has item")
				return
		else:
			if check_if_npc_has_item == CHECK_TRUE:
				run_recursive = false
				emit_signal("command_done")
				print("condition failed: npc does not have item")
				return
	print("condition succeeded")