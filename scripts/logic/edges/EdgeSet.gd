# Takes into account that two different instances with the same values are seen as equal.
class_name EdgeSet
extends RefCounted

var edges: Dictionary[String, Edge] = {}

func add(edge: Edge):
	edges[_edge_to_string(edge)] = edge
func contains(edge: Edge) -> bool:
	return edges.has(_edge_to_string(edge))
func remove(edge: Edge):
	edges.erase(_edge_to_string(edge))

func _edge_to_string(edge: Edge) -> String:
	return edge.from.to_string() + ":" + edge.to.to_string()

func find_edges_connecting_to(coordinate: Coordinate) -> Array[Edge]:
	var result: Array[Edge] = []
	for key in edges.keys():
		if key.begins_with(coordinate.to_string() + ":") or key.ends_with(":" + coordinate.to_string()):
			result.append(edges[key])
	return result
