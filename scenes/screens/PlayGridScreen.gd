class_name PlayGridScreen
extends Control

@onready var GridExecutionViewScene = preload("res://scenes/components/grids/GridExecutionView.tscn")
@onready var StopButton = $VBoxContainer/ActionsSidePanel/VBoxContainer/MarginContainer/VBoxContainer/StopButton
@onready var ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/OrderedOutputView

var grid: Grid
var grid_execution_view: GridExecutionView

func init(_grid: Grid):
	grid = _grid
	ordered_output_view.init(null, grid.expected_output)
	$Grids/GridView.init(grid)

signal go_to_editor(grid: Grid)

func _on_editor_button_pressed() -> void:
	go_to_editor.emit(grid)

func _on_step_button_pressed() -> void:
	if grid_execution_view == null:
		grid_execution_view = GridExecutionViewScene.instantiate()
		grid_execution_view.init($Grids/GridView, ordered_output_view)
		$Grids.add_child(grid_execution_view)
		StopButton.disabled = false
	else:
		grid_execution_view.next_step()
		if not grid_execution_view.has_next_step():
			_on_stop_button_pressed()

func _on_stop_button_pressed() -> void:
	grid_execution_view.queue_free()
	grid_execution_view = null
	StopButton.disabled = true
