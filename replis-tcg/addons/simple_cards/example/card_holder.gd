extends Node2D

@onready var card_container: CardContainer = $CardContainer


func _ready():
	card_container.create_deck(card_container.res_deck.cards)
	card_container.add_in_container(card_container.deck)



func _on_stack_button_pressed():
	card_container.shape = card_container.inventory_shape.STACK


func _on_arc_button_pressed():
	card_container.shape = card_container.inventory_shape.ARC


func _on_rect_button_pressed():
	card_container.shape = card_container.inventory_shape.RECT
