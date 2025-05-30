# Line2D is not able to (easily) pick up mouse events. So we use ColorRect.
class_name EdgeView
extends ColorRect

var from: Coordinate
var to: Coordinate

func _init(_from: Coordinate, _to: Coordinate, cell_size: int):
	from = _from
	to = _to
	
	color = Color.RED
	var width = 4
	
	var from_middle = (Vector2(from.x + 0.5, from.y + 0.5)) * cell_size
	var to_middle = (Vector2(to.x + 0.5, to.y + 0.5)) * cell_size
	var min_x = min(from_middle.x, to_middle.x)
	var min_y = min(from_middle.y, to_middle.y)
	var max_x = max(from_middle.x, to_middle.x)
	var max_y = max(from_middle.y, to_middle.y)

	var horizontal = from_middle.y == to_middle.y
	var vertical = from_middle.x == to_middle.x

	if horizontal:
		position = Vector2(min_x, from_middle.y - width / 2.0)
		size = Vector2(max_x - min_x, width)
	elif vertical:
		position = Vector2(from_middle.x - width / 2.0, min_y)
		size = Vector2(width, max_y - min_y)
	else:
		push_error("Only horizontal or vertical lines supported!")

signal erase_me(edge: EdgeView)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			erase_me.emit(self)
