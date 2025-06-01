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
	return Edge.new(from, to).as_string()
