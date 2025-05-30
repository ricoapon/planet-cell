# Takes into account that two different instances with the same values are seen as equal.
class_name EdgeSet
extends RefCounted

var edges: Dictionary[String, Edge] = {}

func add(edge: Edge):
	edges[_edge_to_string(edge)] = edge
func contains(edge: Edge) -> bool:
	return edges.has(_edge_to_string(edge))
func erase(edge: Edge):
	edges.erase(_edge_to_string(edge))
func find_edge(from: Coordinate, to: Coordinate) -> Edge:
	return edges[_edge_to_string(Edge.new(from, to))]

func _edge_to_string(edge: Edge) -> String:
	return edge.as_string()

func find_edges_connecting_to(coordinate: Coordinate) -> Array[Edge]:
	var result: Array[Edge] = []
	for key in edges.keys():
		if key.begins_with(coordinate.as_string() + ":") or key.ends_with(":" + coordinate.as_string()):
			result.append(edges[key])
	return result
