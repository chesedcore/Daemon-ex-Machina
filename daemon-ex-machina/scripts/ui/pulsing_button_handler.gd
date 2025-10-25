class_name ButtonHandler extends Cascade

@export var buttons: Array[RichTextLabel]
@export var focus_stagger: float = 0.2
@export var focus_tween_time: float = 0.7

@export var shit_under_start: Array[Control]
@export var shit_under_continue: Array[Control]
@export var shit_under_options: Array[Control]
@export var shit_under_credits: Array[Control]

func get_shit() -> Array[Control]:
	return shit_under_start + shit_under_continue + shit_under_options + shit_under_credits
