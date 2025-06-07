class_name GridExecution
extends RefCounted

var grid: Grid
var next_powered_edges: Array[PoweredEdge]
var current_output: OrderedOutput = OrderedOutput.new()
# Maps a coordinate to power.
var show_as_active: CoordinateDictionary

func _init(_grid: Grid):
	grid = _grid
	
	# We start with edges from the starter block.
	# I cannot assign next_powered_edges directly, as casting gives errors. So we work around it.
	var starter_blocks: Array[Coordinate] = grid.getBlocksOfType(StarterBlock)
	next_powered_edges = []
	show_as_active = CoordinateDictionary.new()
	for starter_block in starter_blocks:
		show_as_active.add(starter_block, 1)
		for edge in grid.edges.find_edges_connecting_to(starter_block):
			# Edges don't have a direction, but powered edges do. So we need to make sure
			# we initialize with the right direction.
			if (starter_block.equals(edge.from)):
				next_powered_edges.append(PoweredEdge.new(edge.from, edge.to, 1))
			else:
				next_powered_edges.append(PoweredEdge.new(edge.to, edge.from, 1))

func next_step():
	var new_next_powered_edges: Array[PoweredEdge] = []
	var new_output: Array[SingleOutput] = []
	show_as_active = CoordinateDictionary.new()
	for powered_edge in next_powered_edges:
		var current_coordinate = powered_edge.to
		var current_block = grid.getBlock(current_coordinate)
		
		# Edges always start with step at 0, so we increment as a first action.
		powered_edge.step += 1
		
		# If an edge has length 5 (for example), we need to take 5 steps before we actually activate.
		if powered_edge.length > powered_edge.step:
			new_next_powered_edges.append(powered_edge)
			continue
		
		new_next_powered_edges += current_block.activate(powered_edge, _determine_next_edges(powered_edge))
		if not SingleOutput.new().equals(current_block.get_output()):
			new_output.append(current_block.get_output())
			# The GUI doesn't show the activation of this output block. To make it more logical for
			# players, we show a final active node. We also need to take into account that multiple
			# powered edges could trigger output. So we need to sum those.
			show_as_active.increment(powered_edge.determine_step_coordinate(), powered_edge.power)

	next_powered_edges = _merge_powered_edges(new_next_powered_edges)

	for powered_edge in next_powered_edges:
		show_as_active.add(powered_edge.determine_step_coordinate(), powered_edge.power)
	
	if not new_output.is_empty():
		current_output.next_row()
		for output in new_output:
			current_output.add_output_to_current_row(output)
	
	if not grid.expected_output.fully_contains(current_output):
		# Execution failed, so we stop.
		print("Grid Execution - Failure")
		next_powered_edges = []
	if grid.expected_output.equals(current_output):
		print("Grid Execution - Finished correctly")
		next_powered_edges = []

# If we have two edges that are at the same step, we should merge it into one with the same power.
func _merge_powered_edges(powered_edges: Array[PoweredEdge]) -> Array[PoweredEdge]:
	var result: Array[PoweredEdge] = []
	for powered_edge in powered_edges:
		var matching = _find_first_matching(result, powered_edge)
		if matching == null:
			result.append(powered_edge)
		else:
			matching.power += powered_edge.power
	return result

func _find_first_matching(powered_edges: Array[PoweredEdge], similar_edge: PoweredEdge) -> PoweredEdge:
	for powered_edge in powered_edges:
		if powered_edge.from.equals(similar_edge.from) and powered_edge.to.equals(similar_edge.to) and powered_edge.step == similar_edge.step:
			return powered_edge
	return null

# Locate all other edges from a block that are not the powered edge.
func _determine_next_edges(powered_edge: PoweredEdge) -> Array[Edge]:
	return grid.neighbours(powered_edge.to).filter(
		func(e: Edge): return e.as_string() != powered_edge.to_edge().as_string())

func has_next_step() -> bool:
	return not next_powered_edges.is_empty()
