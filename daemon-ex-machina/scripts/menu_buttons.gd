class_name MenuButtons extends Control

@export var cascade_one: Cascade
@export var cascade_two: Cascade

func _ready() -> void:
	wire_up_signals()

func wire_up_signals() -> void:
	cascade_one.last_cascade_started.connect(
		func(fade: Cascade.FADE) -> void: chain_into(fade, cascade_two)
	)

func chain_into(fade_type: Cascade.FADE, new_cascade: Cascade) -> void:
	if not fade_type == Cascade.FADE.FADE_IN: return
	new_cascade.cascade_in()
