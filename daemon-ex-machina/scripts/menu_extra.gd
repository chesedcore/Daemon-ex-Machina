class_name MenuExtra extends Control

signal go_back(node: MenuExtra)
signal ready_to_eject

@export var cascade: Cascade

var acknowledged: bool = false

func _ready() -> void:
	cascade.cascade_started.connect(_emit_eject)

func eject() -> void:
	cascade.cascade_out(true)

func _emit_eject(fade: Cascade.FADE) -> void:
	if fade == Cascade.FADE.FADE_OUT: ready_to_eject.emit()
