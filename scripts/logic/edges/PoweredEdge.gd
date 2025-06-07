class_name PoweredEdge
extends RefCounted

var from: Coordinate
var to: Coordinate
var power: int
var length: int

# Mutable
var step: int = 0

func _init(_from: Coordinate, _to: Coordinate, _power: int):
	from = _from
	to = _to
	power = _power
	length = round(Vector2i(from.x, from.y).distance_to(Vector2i(to.x, to.y)))

func to_edge() -> Edge:
	return Edge.new(from, to)

func _to_string() -> String:
	return "PoweredEdge[%s,%s,%s,%s,%s]" % [from, to, power, length, step]

func determine_step_coordinate() -> Coordinate:
	var x = from.x
	var y = from.y
	if from.x == to.x:
		if from.y < to.y:
			y += step
		else:
			y -= step
	else:
		if from.x < to.x:
			x += step
		else:
			x -= step
	return Coordinate.new(x, y)
