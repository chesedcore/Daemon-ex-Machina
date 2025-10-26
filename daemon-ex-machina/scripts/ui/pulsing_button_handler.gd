class_name ButtonHandler extends Cascade

@export var buttons: Array[RichTextLabel]

@export var start_button: FuckMyChungusLifeButton
@export var continue_button: FuckMyChungusLifeButton
@export var options_button: FuckMyChungusLifeButton
@export var credits_button: FuckMyChungusLifeButton

@export var focus_stagger: float = 0.2
@export var focus_tween_time: float = 0.7

@export var shit_under_start: Array[Node]
@export var shit_under_continue: Array[Node]
@export var shit_under_options: Array[Node]
@export var shit_under_credits: Array[Node]

@export var focused_button: FuckMyChungusLifeButton

var locked_down: bool = true

func _ready() -> void:
	wire_up_signals()
	super._ready()

func get_shit() -> Array[Node]:
	return shit_under_start + shit_under_continue + shit_under_options + shit_under_credits

func get_button_shit_map(button: RichTextLabel) -> Array[Control]:
	var map: Dictionary[RichTextLabel, Array] = {
		start_button: shit_under_start,
		continue_button: shit_under_continue,
		options_button: shit_under_options,
		credits_button: shit_under_credits,
	}
	
	var out: Array[Control]
	out.assign(map[button])
	return out

func wire_up_signals() -> void:
	for button in buttons:
		button.mouse_entered.connect(refocus_at.bind(button))
	credits_button.clicked.connect(Bus.move_to_credits.emit)

func refocus_at(button: FuckMyChungusLifeButton) -> void:
	
	if locked_down: return
	
	#if already zeroing on the same button we were already focusing on before, exit
	if button == focused_button: return
	
	var previous_button_ref := focused_button
	focused_button = button
	
	var old_mapped_shit: Array[Control]
	if previous_button_ref: old_mapped_shit = get_button_shit_map(previous_button_ref)
	var new_mapped_shit := get_button_shit_map(button)
	
	if previous_button_ref: previous_button_ref.dissipate_out(old_mapped_shit, tween_in_time, stagger_time)
	button.integrate_in(new_mapped_shit, tween_in_time, stagger_time)

func cascade_out(ignore_exclusions: bool = false) -> void:
	#preserve state
	var shit_related_to_current_button := get_button_shit_map(focused_button)
	exclude_these_nodes = get_shit()
	for shit in shit_related_to_current_button:
		exclude_these_nodes.erase(shit)

	var saved_exclusions := exclude_these_nodes.duplicate()
	if ignore_exclusions:
		exclude_these_nodes.clear()

	match cascade_type:
		CASCADE_TYPE.ORDERED:
			_cascade_out_ordered()
		CASCADE_TYPE.HITZONE, CASCADE_TYPE.SINE_ORDERED_HITZONE:
			_cascade_out_hitzone()
		CASCADE_TYPE.RANDOM:
			_cascade_out_random()

	if ignore_exclusions:
		exclude_these_nodes = saved_exclusions
