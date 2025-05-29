# Takes into account that two different instances with the same values are seen as equal.
class_name EdgeSet
extends RefCounted

var edges: Dictionary[String, bool] = {}

func add(edge: Edge):
	edges[_edge_to_string(edge)] = true
func contains(edge: Edge) -> bool:
	return edges.has(_edge_to_string(edge))
func remove(edge: Edge):
	edges.erase(_edge_to_string(edge))

func _edge_to_string(edge: Edge) -> String:
	return edge.from.to_string() + ":" + edge.to.to_string()
