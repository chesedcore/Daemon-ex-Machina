class_name MainMenu extends Control

@export var cascades: Array[Cascade]

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("fly_in"):
		cascades[0].cascade_in()
	elif Input.is_action_just_pressed("fly_out"):
		for cascade in cascades: cascade.cascade_out()
