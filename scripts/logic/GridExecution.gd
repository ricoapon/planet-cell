class_name GridExecution
extends RefCounted

var grid: Grid
var next_powered_edges: Array[PoweredEdge]
var current_output: OrderedOutput = OrderedOutput.new()

func _init(_grid: Grid):
	grid = _grid
	next_powered_edges = grid.getBlocksOfType(StarterBlock).map(
		func(c): return PoweredEdge.new(null, c, 1))

func nextStep():
	var new_next_powered_edges: Array[PoweredEdge] = []
	current_output.next_row()
	for powered_edge in next_powered_edges:
		var current_coordinate = powered_edge.to
		var current_block = grid.getBlock(current_coordinate)
		
		# If an edge has length 5, we need to take 5 steps before we actually activate.
		if powered_edge.length > powered_edge.step:
			powered_edge.step += 1
			new_next_powered_edges.append(powered_edge)
			continue
		
		new_next_powered_edges += current_block.activate(powered_edge, _determine_next_edges(powered_edge))
		current_output.add_output_to_current_row(current_block.get_output())
	
	next_powered_edges = _merge_powered_edges(new_next_powered_edges)
	
	if not grid.expected_output.fully_contains(current_output):
		# Execution failed, so we stop.
		print("Grid Execution - Failure")
		next_powered_edges = []
	if grid.expected_output.equals(current_output):
		print("Grid Execution - Finished correctly")
		next_powered_edges = []

# If we have two edges that are at the same step, we should merge it into one with the same power.
func _merge_powered_edges(powered_edges: Array[PoweredEdge]) -> Array[PoweredEdge]:
	var result = []
	for powered_edge in powered_edges:
		var matching = _find_first_matching(result, powered_edge)
		if matching == null:
			result.append(powered_edge)
		else:
			matching.power += powered_edge.power
	return result

func _find_first_matching(powered_edges: Array[PoweredEdge], similar_edge: PoweredEdge) -> PoweredEdge:
	var result = []
	for powered_edge in powered_edges:
		if powered_edge.from.equals(similar_edge.from) and powered_edge.to.equals(similar_edge.to) and powered_edge.step == similar_edge.step:
			return powered_edge
	return null

# Locate all other edges from a block that are not the powered edge.
func _determine_next_edges(poweredEdge: PoweredEdge) -> Array[Edge]:
	return grid.getNeighbours(poweredEdge.to).filter(
		func(e): return e.x != poweredEdge.from.x && e.y != poweredEdge.from.y)

func hasNextStep() -> bool:
	return not next_powered_edges.is_empty()
