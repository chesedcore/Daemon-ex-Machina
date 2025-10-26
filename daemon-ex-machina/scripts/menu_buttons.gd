class_name MenuButtons extends Control

@export var cascade_one: Cascade
@export var cascade_two: ButtonHandler
@export var extras_dock: Control

func _ready() -> void:
	wire_up_signals()

func wire_up_signals() -> void:
	cascade_one.last_cascade_started.connect(
		func(fade: Cascade.FADE) -> void: chain_into(fade, cascade_two)
	)
	cascade_one.cascade_finished.connect(unlock_menu, CONNECT_ONE_SHOT)
	Bus.move_to_credits.connect(transition_to_credits)

func chain_into(fade_type: Cascade.FADE, new_cascade: Cascade) -> void:
	if not fade_type == Cascade.FADE.FADE_IN: return
	new_cascade.cascade_in()

func unlock_menu(fade_type: Cascade.FADE) -> void:
	if not fade_type == Cascade.FADE.FADE_IN: return
	cascade_two.locked_down = false

func transition_to_credits() -> void:
	cascade_one.cascade_out()
	cascade_two.cascade_out(true)
	var credits_scene: StaticScreen = preload("res://scenes/credits.tscn").instantiate()
	extras_dock.add_child(credits_scene)
	credits_scene.go_back.connect(transition_to_main, CONNECT_ONE_SHOT)

func transition_to_main(node: MenuExtra) -> void:
	node.acknowledged = true
	node.eject.call_deferred()
	node.cascade.last_cascade_started.connect(
		func(fade: Cascade.FADE) -> void:
			if not fade == Cascade.FADE.FADE_OUT:assert(false, "Something went very wrong.")
			node.queue_free()
	)
	cascade_one.cascade_in()
