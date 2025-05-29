class_name LineDictionary
extends RefCounted

var lines: Dictionary[String, Line2D] = {}
var coordinates: Dictionary[Line2D, Array] = {}

func add(line: Line2D, from: Coordinate, to: Coordinate):
	var key = _create_key(from, to)
	lines[key] = line
	coordinates[line] = [from, to]

func get_line(from: Coordinate, to: Coordinate) -> Line2D:
	var key = _create_key(from, to)
	return lines[key]

func get_coordinates(line: Line2D) -> Array[Coordinate]:
	return coordinates[line] as Array[Coordinate]

func remove_line(line: Line2D):
	var key = _create_key(coordinates[line][0], coordinates[line][1])
	lines.erase(key)
	coordinates.erase(line)

func _create_key(from: Coordinate, to: Coordinate):
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
	return "%s,%s -> %s,%s" % [c1.x, c1.y, c2.x, c2.y]
