extends Node

func _ready():
	test_edge_set()
	test_single_output()
	test_ordered_output()
	test_json_enums()
	get_tree().quit()

func test_edge_set():
	var edge_set = EdgeSet.new()
	var from = Coordinate.new(1, 2)
	var to = Coordinate.new(2, 2)
	edge_set.add(Edge.new(from, to))
	assert(edge_set.contains(Edge.new(from, to)))
	edge_set.erase(Edge.new(from, to))
	assert(not edge_set.contains(Edge.new(from, to)))

func test_single_output():
	var output1 = SingleOutput.new()
	output1.add_color(SingleOutput.OutputColor.RED, 3)
	var output2 = SingleOutput.new()
	output2.add_color(SingleOutput.OutputColor.RED, 3)
	var output3 = SingleOutput.new()
	output3.add_color(SingleOutput.OutputColor.GREEN, 1)
	
	assert(output1.equals(output2))
	assert(not output1.equals(output3))
	
	output1.add_output(output2)
	assert(output1.times_color_is_present(SingleOutput.OutputColor.RED) == 6)

func test_ordered_output():
	var output1 = SingleOutput.new()
	output1.add_color(SingleOutput.OutputColor.RED, 3)
	var output3 = SingleOutput.new()
	output3.add_color(SingleOutput.OutputColor.GREEN, 1)
	
	var ordered_output1 = OrderedOutput.new()
	ordered_output1.next_row()
	ordered_output1.add_output_to_current_row(output1)
	ordered_output1.add_output_to_current_row(output3)
	ordered_output1.next_row()
	ordered_output1.add_output_to_current_row(output1)
	
	var matches = OrderedOutput.new()
	ordered_output1.next_row()
	ordered_output1.add_output_to_current_row(output1)
	ordered_output1.add_output_to_current_row(output3)
	var mismatch = OrderedOutput.new()
	mismatch.next_row()
	mismatch.add_output_to_current_row(output1)

	assert(ordered_output1.fully_contains(matches))
	assert(not ordered_output1.fully_contains(mismatch))
	
func test_json_enums():
	var single_output_before = SingleOutput.new()
	single_output_before.add_color(SingleOutput.OutputColor.GREEN, 3)
	var single_output_after = SingleOutput.from_dict(single_output_before.to_dict())
	assert(single_output_after.times_color_is_present(SingleOutput.OutputColor.GREEN) == 3)
	assert(single_output_after.times_color_is_present(SingleOutput.OutputColor.RED) == 0)
	
	var ordered_output_before = OrderedOutput.new()
	ordered_output_before.next_row()
	ordered_output_before.add_output_to_current_row(single_output_before)
	var ordered_output_after = OrderedOutput.from_dict(ordered_output_before.to_dict())
	assert(ordered_output_after.outputs()[0].equals(single_output_before))
