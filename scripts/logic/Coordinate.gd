class_name Coordinate
extends RefCounted

var x: int
var y: int

func _init(_x: int, _y: int):
	x = _x
	y = _y

func equals(other: Coordinate):
	return x == other.x and y == other.y
