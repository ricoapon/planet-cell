class_name Edge
extends RefCounted

var from: Coordinate
var to: Coordinate

func _init(_from: Coordinate, _to: Coordinate):
	from = _from
	to = _to

func to_powered_edge(power: int) -> PoweredEdge:
	return PoweredEdge.new(from, to, power)
