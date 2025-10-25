@tool
class_name CenteringRect extends ColorRect

@export_tool_button("Center Pivot") var center_button: Callable = centre_pivot

func centre_pivot() -> void:
	pivot_offset = size/2
