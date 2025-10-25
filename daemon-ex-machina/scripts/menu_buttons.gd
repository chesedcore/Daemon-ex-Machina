class_name MenuButtons extends Control

@export var cascade_one: Cascade
@export var cascade_two: ButtonHandler

func _ready() -> void:
	wire_up_signals()

func wire_up_signals() -> void:
	cascade_one.last_cascade_started.connect(
		func(fade: Cascade.FADE) -> void: chain_into(fade, cascade_two)
	)
	cascade_one.cascade_finished.connect(unlock_menu, CONNECT_ONE_SHOT)

func chain_into(fade_type: Cascade.FADE, new_cascade: Cascade) -> void:
	if not fade_type == Cascade.FADE.FADE_IN: return
	new_cascade.cascade_in()

func unlock_menu(fade_type: Cascade.FADE) -> void:
	if not fade_type == Cascade.FADE.FADE_IN: return
	cascade_two.locked_down = false
