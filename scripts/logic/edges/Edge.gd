class_name Edge
extends RefCounted

var from: Coordinate
var to: Coordinate

func _init(_from: Coordinate, _to: Coordinate):
	from = _from
	to = _to

func to_powered_edge(power: int) -> PoweredEdge:
	return PoweredEdge.new(from, to, power)

func as_string() -> String:
	# A line from A to B is also a line from B to A. We sort the coordinates such
	# that we have a consistent way of defining A. Which way we choose doesn't matter
	# so much. We choose smaller coordinate first, first looking at x.
	var c1: Coordinate
	var c2: Coordinate
	if from.x < to.x:
		c1 = from
		c2 = to
	elif from.x > to.x:
		c1 = to
		c2 = from
	else:
		if from.y < to.y:
			c1 = from
			c2 = to
		else:
			# If the Y value is the same, the coordinates are the same.
			c1 = to
			c2 = from
	return c1.to_string() + ":" + c2.to_string()
