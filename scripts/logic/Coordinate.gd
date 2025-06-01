class_name Coordinate
extends RefCounted

var x: int
var y: int

func _init(_x: int, _y: int):
	x = _x
	y = _y

func equals(other: Coordinate):
	return x == other.x and y == other.y

func as_string() -> String:
	return "%s,%s" % [x, y]

func _to_string() -> String:
	return "Coordinate[%s,%s]" % [x, y]

func to_dict() -> Dictionary:
	return {
		"x": x,
		"y": y
	}

static func from_dict(data: Dictionary) -> Coordinate:
	return Coordinate.new(data["x"], data["y"])
