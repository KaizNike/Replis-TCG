extends Node

#General Settings
var use_shadows: bool = true ##Sets the generation of shadows of the cards
var use_tooltips: bool = true ##Shows tooltips on cards

var play_key: String = "ui_accept" ##Input key used to play cards
var use_key: StringName = "use"
var move_key: StringName = "move"

##Use this array to add groups of nodes 
var target_filter: Array[String] = ["entity", "player"]

func get_targets() -> Array:
	var targets_dict = {}
	
	for group in target_filter:
		var temp: Array = get_tree().get_nodes_in_group(group)
		for node in temp:
			targets_dict[node] = true
	
	return targets_dict.keys()

func _ready():
	add_input(use_key, MOUSE_BUTTON_LEFT, true)
	add_input(move_key, MOUSE_BUTTON_RIGHT, true)


func add_input(action: StringName, input_key, is_mouse_input: bool = false):
	if InputMap.has_action(action):
		return
	
	InputMap.add_action(action)
	var event: InputEvent
	if is_mouse_input:
		event = InputEventMouseButton.new()
		event.button_index = input_key
	else:
		event = InputEventKey.new()
		event.physical_keycode = input_key
	InputMap.action_add_event(action, event)


func  remove_input(action: StringName):
	if InputMap.has_action(action):
		InputMap.erase_action(action)
