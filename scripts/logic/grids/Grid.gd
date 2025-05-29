class_name Grid
extends RefCounted

var width: int
var height: int
var grid: Dictionary[Coordinate, AbstractBlock] = {}
var edges: EdgeSet = EdgeSet.new()
var expected_output: OrderedOutput = OrderedOutput.new()

func _init(_width: int, _height: int):
	width = _width
	height = _height

func setExpectedOutput(_expected_output: OrderedOutput):
	expected_output = _expected_output

func setBlock(coordinate: Coordinate, block: AbstractBlock):
	grid[coordinate] = block
func clearBlock(coordinate: Coordinate):
	grid.erase(coordinate)
func getBlock(coordinate: Coordinate) -> AbstractBlock:
	return grid[coordinate]
func addEdge(from: Coordinate, to: Coordinate):
	edges.add(Edge.new(from, to))
func removeEdge(from: Coordinate, to: Coordinate):
	edges.remove(Edge.new(from, to))

func getNeighbours(c: Coordinate) -> Array[Edge]:
	return [
		Edge.new(c, Coordinate.new(c.x + 1, c.y)),
		Edge.new(c, Coordinate.new(c.x - 1, c.y)),
		Edge.new(c, Coordinate.new(c.x, c.y + 1)),
		Edge.new(c, Coordinate.new(c.x, c.y - 1))
	].filter(func(e): return edges.contains(e))

func getBlocksOfType(block_type) -> Array[Coordinate]:
	var result: Array[Coordinate] = []
	for coordinate in grid.keys():
		if is_instance_of(grid[coordinate], block_type):
			result.append(coordinate)
	return result
