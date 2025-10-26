class_name StaticScreen extends MenuExtra

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			if event.button_index == MOUSE_BUTTON_RIGHT:
				#no need to trigger go back if a go back has already been acknowledged
				if acknowledged: return
				print("Going back...")
				go_back.emit(self)
