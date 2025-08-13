##Queues free the card on use
class_name KillCardEffectResource
extends EffectResource

func use(_card: CardSimple):
	_card.queue_free()
