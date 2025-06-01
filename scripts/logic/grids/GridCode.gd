# This functionality could have been part of Grid.gd. However, I want to split
# up the files to keep it a bit more readable. This works just fine.
class_name GridCode
extends RefCounted

static func convert_to_code(grid: Grid) -> String:
	var coordinate_to_block: Dictionary = {}
	for coordinate_as_string in grid.coordinates.keys():
		var coordinate_dict = grid.coordinates[coordinate_as_string].to_dict()
		var coordinate_dict_as_string = JSON.stringify(coordinate_dict)
		var block_dict = grid.grid[coordinate_as_string].to_dict()
		coordinate_to_block[coordinate_dict_as_string] = block_dict
	
	var edges: Array[Dictionary] = []
	for edge: Edge in grid.edges.edges.values():
		edges.append(edge.to_dict())

	var dict = {
		"width": grid.width,
		"height": grid.height,
		"coordinate_to_block": coordinate_to_block,
		"edges": edges,
		"expected_output": grid.expected_output.to_dict()
	}
	
	return Marshalls.utf8_to_base64(JSON.stringify(dict))

static func convert_to_grid(code: String) -> Grid:
	var data_as_string: String = Marshalls.base64_to_utf8(code)
	var json = JSON.new()
	if json.parse(data_as_string) != OK:
		push_error("Could not parse string to dictionary")
		return null
	
	var data: Dictionary = json.data
	var grid = Grid.new(int(data["width"]), int(data["height"]))
	
	# The best way to implement the blocks is to add them one by one.
	var coordinate_to_block: Dictionary = data["coordinate_to_block"]
	for coordinate_dict_as_string: String in coordinate_to_block.keys():
		if json.parse(coordinate_dict_as_string) != OK:
			push_error("Could not parse coordinate to dicitonary", coordinate_dict_as_string)
			return null
		var coordinate_dict = json.data
		var block_dict = coordinate_to_block[coordinate_dict_as_string]
		var coordinate: Coordinate = Coordinate.from_dict(coordinate_dict)
		var block: AbstractBlock = AbstractBlock.from_dict(block_dict)
		grid.add_block(coordinate, block)
	
	# The best way for edges is to add them one by one as well.
	var edges_dict: Array = data["edges"]
	for edge_dict: Dictionary in edges_dict:
		var edge = Edge.from_dict(edge_dict)
		grid.add_edge(edge.from, edge.to)
	
	grid.set_expected_output(OrderedOutput.from_dict(data["expected_output"]))
	
	return grid
