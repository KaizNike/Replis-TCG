@tool
extends EditorPlugin

const CARD_GLOBAL = "CardGlobal"
var use_key: StringName = "use"
var move_key: StringName = "move"

func _enter_tree():
	add_autoload_singleton(CARD_GLOBAL, "res://addons/simple_cards/scripts/card_global.gd")
	
func _exit_tree():
	remove_autoload_singleton(CARD_GLOBAL)
