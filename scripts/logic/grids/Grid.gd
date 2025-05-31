class_name Grid
extends RefCounted

var width: int
var height: int
# String is always a coordinate.
var grid: Dictionary[String, AbstractBlock] = {}
var coordinates: Dictionary[String, Coordinate] = {}
var edges: EdgeSet = EdgeSet.new()
var expected_output: OrderedOutput = OrderedOutput.new()

func _init(_width: int, _height: int):
	width = _width
	height = _height

func set_expected_output(_expected_output: OrderedOutput):
	expected_output = _expected_output

func add_block(coordinate: Coordinate, block: AbstractBlock):
	grid[coordinate.as_string()] = block
	coordinates[coordinate.as_string()] = coordinate
func erase_block(coordinate: Coordinate):
	grid.erase(coordinate.as_string())
func getBlock(coordinate: Coordinate) -> AbstractBlock:
	return grid[coordinate.as_string()]
func add_edge(from: Coordinate, to: Coordinate):
	edges.add(Edge.new(from, to))
func erase_edge(edge: Edge):
	edges.erase(edge)
func get_edge(from: Coordinate, to: Coordinate) -> Edge:
	return edges.find_edge(from, to)

func neighbours(c: Coordinate) -> Array[Edge]:
	var result = edges.find_edges_connecting_to(c).filter(func(e): return edges.contains(e)) as Array[Edge]
	return result

func getBlocksOfType(block_type) -> Array[Coordinate]:
	var result: Array[Coordinate] = []
	for coordinate_as_string in grid.keys():
		if is_instance_of(grid[coordinate_as_string], block_type):
			result.append(coordinates[coordinate_as_string])
	return result
