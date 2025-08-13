extends TextureRect
class_name RepliCardTex

var tween : Tween
var rot_tween : Tween

var old_z_index = 0

func _on_mouse_entered() -> void:

	if tween:
		tween.kill()
	if rot_tween:
		rot_tween.kill()
	rot_tween = create_tween()
	var target_rotation = -get_parent().get_parent().rotation
	rot_tween.tween_property(self, "rotation", target_rotation, 0.3).as_relative().set_trans(Tween.TRANS_QUAD)#.set_ease(Tween.EASE_OUT)
	await rot_tween.finished
	rot_tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.4, 1.4), 0.3).as_relative().set_trans(Tween.TRANS_ELASTIC)
	await tween.finished
	
	await get_tree().process_frame
	var visible_size = get_viewport().get_visible_rect().size
	var mouse_pos = get_global_mouse_position()
	var new_pos = mouse_pos - size * scale / 2

	new_pos.x = clamp(new_pos.x, 0, visible_size.x - size.x * scale.x)
	new_pos.y = clamp(new_pos.y, 0, visible_size.y - size.y * scale.y)
	old_z_index = z_index
	z_index = 100
	global_position = new_pos
	print(global_position)


func _on_mouse_exited() -> void:
	rotation = 0
	z_index = old_z_index
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.2).from_current().set_trans(Tween.TRANS_BACK)
	await tween.finished
	position = Vector2(0, 0)
	top_level = false


#func _draw():
	#var bounds = size
	#draw_rect(Rect2(position,size), Color(1, 0, 0, 0.3), false)
	#draw_rect(get_rect(),Color.YELLOW_GREEN,false)
