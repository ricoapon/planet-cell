class_name PoweredEdge
extends RefCounted

var from: Coordinate
var to: Coordinate
var power: int
var length: int

# Mutable
var step: int = 1

func _init(_from: Coordinate, _to: Coordinate, _power: int):
	from = _from
	to = _to
	power = _power
	
	# Starting edge has null, so we do it like this.
	if from == null:
		length = 1
	else:
		# It shouldn't need rounding, but because distance_to is a float I thought it would be better to
		# convert to an int like this.
		length = round(Vector2i(from.x, from.y).distance_to(Vector2i(to.x, to.y)))
