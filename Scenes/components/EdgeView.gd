class_name EdgeView
extends Line2D

var from: Coordinate
var to: Coordinate

func _init(_from: Coordinate, _to: Coordinate, cell_size: int):
	from = _from
	to = _to
	
	default_color = Color.RED
	width = 4
	var from_middle = (Vector2(from.x + 0.5, from.y + 0.5)) * cell_size
	var to_middle = (Vector2(to.x + 0.5, to.y + 0.5)) * cell_size
	add_point(from_middle)
	add_point(to_middle)
