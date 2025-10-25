class_name MainMenu extends Control

@export var cascade_one: Cascade
@export var cascade_two: ButtonHandler
@export var menu: MenuButtons


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fly_in"):
		cascade_one.cascade_in()
	elif Input.is_action_just_pressed("fly_out"):
		cascade_one.cascade_out()
		cascade_two.cascade_out(true)
