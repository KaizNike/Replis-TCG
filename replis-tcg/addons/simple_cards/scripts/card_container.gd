@tool
@icon("res://addons/simple_cards/assets/icon_container.png")
class_name CardContainerSimple extends Node2D

@export var res_deck: CardDeck

@export var shape: inventory_shape = inventory_shape.ARC:
	set(v): 
		shape = v
		notify_property_list_changed()
		spread_cards(deck)
#Arc Settings
@export var radius: float = 200
@export var angle_limit: float = 90
@export var max_card_spread_angle: float = 5
@export_range(0.0, 360.0) var orinetation: float = 0
#Rect Settings
@export var size: Vector2 = Vector2(200,100)
@export var padding: Vector2 = Vector2(0,0)
@export var animation_speed: float = 0.25

enum inventory_shape {
	ARC,
	RECT,
	STACK,
}

var deck: Array[CardSimple] = []

func _validate_property(property: Dictionary) -> void:
	if property.name in ["size", "padding"]:
		match shape:
			inventory_shape.RECT:
				property.usage = PROPERTY_USAGE_DEFAULT
			_:
				property.usage = PROPERTY_USAGE_NO_EDITOR
	elif property.name in ["radius", "angle_limit", "max_card_spread_angle", "orinetation"]:
		match shape:
			inventory_shape.ARC:
				property.usage = PROPERTY_USAGE_DEFAULT
			_:
				property.usage = PROPERTY_USAGE_NO_EDITOR


func add_in_container(deck: Array[CardSimple]):
	for card: CardSimple in deck:
		if card.get_parent() == null:
			add_child(card)


func create_deck(res_deck: Array[CardResource]):
	if !deck.is_empty():
		return
	for res: CardResource in res_deck:
		var temp_card: CardSimple = CardSimple.spawn_card(res)
		deck.append(temp_card)


#region Spread Management
## UPDATE WITH LESS ROTATION
	
func update_card_transform(_card: CardSimple, _angle: float) -> void:
	_card.handle_movement(get_card_pos(_angle), false, animation_speed)
	_card.set_rotation(deg_to_rad(_angle + 90))


func get_card_pos(angle_in_deg: float) -> Vector2:
	var x: float = radius * cos(deg_to_rad(angle_in_deg))
	var y: float = radius * sin(deg_to_rad(angle_in_deg))
	return Vector2(x,y)


func spread_cards(_deck: Array[CardSimple]):
	if _deck.is_empty():
		return
	match shape:
		inventory_shape.ARC:
			arc_spread(_deck)
		inventory_shape.RECT:
			rect_spread(_deck)
		inventory_shape.STACK:
			stack_spread(_deck)


func arc_spread(_deck: Array[CardSimple]) -> void:
	var card_spread = min(angle_limit / _deck.size(), max_card_spread_angle)
	var current_angle = -(card_spread * (_deck.size() - 1))/2 - orinetation
	for i in _deck.size():
		update_card_transform(_deck[i], current_angle)
		current_angle += card_spread


func rect_spread(_deck: Array[CardSimple]) -> void:
	var card_size: Vector2 = _deck[0].size + padding
	var max_columns:int  = size.x / card_size.x
	var max_rows: int = size.y / card_size.y
	
	for i in _deck.size():
		var card: CardSimple = _deck[i]
		var row = i / max_columns
		var col = i % max_columns
		
		var x_pos = col * (card_size.x)
		var y_pos = row * (card_size.y)
		
		card.handle_movement(Vector2(x_pos, y_pos))
		card.set_rotation(0)
	

func stack_spread(_deck: Array[CardSimple]):
	for card: CardSimple in _deck:
		card.handle_movement(Vector2(0, 0))
		card.set_rotation(0)

#endregion
