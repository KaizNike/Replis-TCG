extends TextureRect
class_name RepliCardTex


func _on_mouse_entered() -> void:
	var tween : Tween
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.4, 1.4), 0.3).as_relative().set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	
	await get_tree().process_frame
	var visible_size = get_viewport().get_visible_rect().size
	var mouse_pos = get_global_mouse_position()
	var new_pos = mouse_pos - size * scale / 2

	new_pos.x = clamp(new_pos.x, 0, visible_size.x - size.x * scale.x)
	new_pos.y = clamp(new_pos.y, 0, visible_size.y - size.y * scale.y)

	global_position = new_pos


func _on_mouse_exited() -> void:
	var tween : Tween
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2).from_current().set_trans(Tween.TRANS_BACK)
	await tween.finished
	position = Vector2(0, 0)
	top_level = false
