extends Node2D

@onready var GridExecutionViewScene = preload("res://scenes/components/grids/GridExecutionView.tscn")

var view: GridExecutionView

func _ready():
	# TODO: Have this until we can modify it in the GUI.
	var output = SingleOutput.new()
	output.add_color(SingleOutput.OutputColor.GREEN, 1)
	var expected_output = OrderedOutput.new()
	expected_output.next_row()
	expected_output.add_output_to_current_row(output)
	$GridView.grid.set_expected_output(expected_output)

func _on_button_pressed() -> void:
	var grid_execution_view = GridExecutionViewScene.instantiate()
	grid_execution_view.init($GridView)
	view = grid_execution_view
	add_child(view)

func _on_button_2_pressed() -> void:
	view.next_step()
