extends Node2D

@onready var GridExecutionViewScene = preload("res://scenes/components/grids/GridExecutionView.tscn")

var view: GridExecutionView

func _ready():
	# TODO: Have this until we can modify it in the GUI.
	var output = SingleOutput.new()
	output.add_color(SingleOutput.OutputColor.YELLOW, 1)
	var expected_output = OrderedOutput.new()
	expected_output.next_row()
	expected_output.add_output_to_current_row(output)
	$Middle/GridView.grid.set_expected_output(expected_output)
	
	var row1 = SingleOutput.new()
	row1.add_color(SingleOutput.OutputColor.YELLOW, 1)
	row1.add_color(SingleOutput.OutputColor.RED, 2)
	var row2 = SingleOutput.new()
	row2.add_color(SingleOutput.OutputColor.YELLOW, 4)
	var ordered_output = OrderedOutput.new()
	ordered_output.next_row()
	ordered_output.add_output_to_current_row(row1)
	ordered_output.next_row()
	ordered_output.add_output_to_current_row(row2)
	$OrderedOutputView.init(ordered_output)
	
	# Just a test case for easy setup.
	$Middle/GridView.place_block(Coordinate.new(5, 5), StarterBlock.new())
	$Middle/GridView.place_block(Coordinate.new(7, 5), SplitBlock.new())
	$Middle/GridView.place_block(Coordinate.new(9, 5), SplitBlock.new())
	$Middle/GridView.place_block(Coordinate.new(7, 7), SplitBlock.new())
	$Middle/GridView.place_block(Coordinate.new(9, 7), SplitBlock.new())
	#$Middle/GridView.place_block(Coordinate.new(9, 13), OutputBlock.new(SingleOutput.OutputColor.YELLOW))
	$Middle/GridView.add_edge(Coordinate.new(5, 5), Coordinate.new(7, 5))
	$Middle/GridView.add_edge(Coordinate.new(7, 5), Coordinate.new(7, 7))
	$Middle/GridView.add_edge(Coordinate.new(9, 5), Coordinate.new(9, 7))
	$Middle/GridView.add_edge(Coordinate.new(7, 5), Coordinate.new(9, 5))
	$Middle/GridView.add_edge(Coordinate.new(7, 7), Coordinate.new(9, 7))
	#$Middle/GridView.add_edge(Coordinate.new(9, 7), Coordinate.new(9, 13))
	

func _on_button_pressed() -> void:
	var grid_execution_view = GridExecutionViewScene.instantiate()
	grid_execution_view.init($Middle/GridView)
	view = grid_execution_view
	$Middle.add_child(view)

func _on_button_2_pressed() -> void:
	view.next_step()
