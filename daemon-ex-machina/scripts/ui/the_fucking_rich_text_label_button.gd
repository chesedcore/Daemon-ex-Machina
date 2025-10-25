class_name FuckMyChungusLifeButton extends RichTextLabel

func shake() -> void:
	self.text = "[shake]"+self.name

func remain_still() -> void:
	self.text = self.name

var tween: Tween
func dissipate_out(owned_shit: Array[Control], tween_time: float, stagger_time: float) -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	remain_still()
	var cum_delay := 0.0
	tween.set_parallel(true)
	for shit in owned_shit:
		tween.tween_property(shit, "scale", Vector2(-2,0), tween_time).set_delay(cum_delay)
		cum_delay += stagger_time

func integrate_in(owned_shit: Array[Control], tween_time: float, stagger_time: float) -> void:
	if tween: tween.kill()
	tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_EXPO)
	shake()
	var cum_delay := 0.0
	tween.set_parallel(true)
	for shit in owned_shit:
		tween.tween_property(shit, "scale", Vector2(1,1), tween_time).set_delay(cum_delay)
		cum_delay += stagger_time
