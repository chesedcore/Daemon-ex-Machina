class_name ButtonHandler extends Cascade

@export var buttons: Array[RichTextLabel]

@export var start_button: FuckMyChungusLifeButton
@export var continue_button: FuckMyChungusLifeButton
@export var options_button: FuckMyChungusLifeButton
@export var credits_button: FuckMyChungusLifeButton

@export var focus_stagger: float = 0.2
@export var focus_tween_time: float = 0.7

@export var shit_under_start: Array[Control]
@export var shit_under_continue: Array[Control]
@export var shit_under_options: Array[Control]
@export var shit_under_credits: Array[Control]

@export var focused_button: FuckMyChungusLifeButton

func _ready() -> void:
	super._ready()
	wire_up_signals()

func get_shit() -> Array[Control]:
	return shit_under_start + shit_under_continue + shit_under_options + shit_under_credits

func get_button_shit_map(button: RichTextLabel) -> Array[Control]:
	var map: Dictionary[RichTextLabel, Array] = {
		start_button: shit_under_start,
		continue_button: shit_under_continue,
		options_button: shit_under_options,
		credits_button: shit_under_credits,
	}
	
	var out: Array[Control] = map[button]
	return out

func wire_up_signals() -> void:
	for button in buttons:
		button.mouse_entered.connect(refocus_at.bind(button))

func refocus_at(button: FuckMyChungusLifeButton) -> void:
	
	#if already zeroing on the same button we were already focusing on before, exit
	if button == focused_button: return
	
	var previous_button_ref := focused_button
	focused_button = button
	
	var old_mapped_shit := get_button_shit_map(previous_button_ref)
	var new_mapped_shit := get_button_shit_map(button)
	
	previous_button_ref.dissipate_out(old_mapped_shit, tween_in_time, stagger_time)
	button.integrate_in(new_mapped_shit, tween_in_time, stagger_time)
