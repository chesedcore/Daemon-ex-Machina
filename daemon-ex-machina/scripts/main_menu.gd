class_name MainMenu extends Control

@export var cascade: Cascade

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fly_in"):
		cascade.cascade_in()
	elif Input.is_action_just_pressed("fly_out"):
		cascade.cascade_out()
