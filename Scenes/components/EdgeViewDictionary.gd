class_name EdgeViewDictionary
extends RefCounted

var edges: Dictionary[String, EdgeView] = {}

func add(edge: EdgeView):
	var key = _create_key(edge.from, edge.to)
	edges[key] = edge

func get_edge_view(from: Coordinate, to: Coordinate) -> EdgeView:
	var key = _create_key(from, to)
	return edges[key]

func erase_edge(edge: EdgeView):
	var key = _create_key(edge.from, edge.to)
	edges.erase(key)

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
