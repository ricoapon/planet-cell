class_name PlayGridScreen
extends Control

@onready var GridExecutionViewScene = preload("res://scenes/components/grids/GridExecutionView.tscn")
@onready var StopButton = $VBoxContainer/ActionsSidePanel/VBoxContainer/MarginContainer/VBoxContainer/StopButton

var grid: Grid
var grid_execution_view: GridExecutionView

func init(_grid: Grid):
	grid = _grid
	var ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/OrderedOutputView
	ordered_output_view.init(null, grid.expected_output)
	$Grids/GridView.init(grid)

signal go_to_editor(grid: Grid)

func _on_editor_button_pressed() -> void:
	go_to_editor.emit(grid)

func _on_step_button_pressed() -> void:
	if grid_execution_view == null:
		grid_execution_view = GridExecutionViewScene.instantiate()
		grid_execution_view.init($Grids/GridView)
		$Grids.add_child(grid_execution_view)
		StopButton.disabled = false
	
	grid_execution_view.next_step()
	if not grid_execution_view.has_next_step():
		grid_execution_view = null
		StopButton.disabled = true
