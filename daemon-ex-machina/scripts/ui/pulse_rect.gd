class_name PulsingRect extends Control

@export var ref_rect: CenteringRect

func pulse() -> void:
	var rect: ColorRect = preload("res://scenes/random_ass_square.tscn").instantiate()
	add_child(rect)
	move_child(rect, 0)
	rect.color = Color.SKY_BLUE
	rect.global_position = ref_rect.global_position
	var tween := create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	tween.set_parallel(true)
	tween.tween_property(rect, "scale", Vector2.ONE * 1.5, 2)
	tween.tween_property(rect, "color", Color(0,0,0,0), 2)
	tween.finished.connect(rect.queue_free, CONNECT_ONE_SHOT)
