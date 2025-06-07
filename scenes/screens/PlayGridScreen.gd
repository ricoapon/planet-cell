class_name PlayGridScreen
extends Control

@onready var GridExecutionViewScene = preload("res://scenes/components/grids/GridExecutionView.tscn")
@onready var StopButton = $VBoxContainer/ActionsSidePanel/VBoxContainer/MarginContainer/VBoxContainer/StopButton
@onready var ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/OrderedOutputView
@onready var won_accept_dialog = $WonAcceptDialog
@onready var lost_accept_dialog = $LostAcceptDialog

var grid: Grid
var grid_execution_view: GridExecutionView
var editor_mode: bool

signal next_level
signal go_to_editor(grid: Grid)
signal back

func init(_grid: Grid, _editor_mode: bool = false):
	grid = _grid
	editor_mode = _editor_mode
	if not editor_mode:
		$VBoxContainer/ActionsSidePanel/VBoxContainer/MarginContainer/VBoxContainer/EditorButton.hide()
	ordered_output_view.init(null, grid.expected_output)
	$Grids/GridView.init(grid)

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
		if grid_execution_view.state() == GridExecution.State.WON:
			won_accept_dialog.popup_centered()
			
		elif grid_execution_view.state() == GridExecution.State.LOST:
			lost_accept_dialog.popup_centered()

func _on_next_level():
	next_level.emit()

# This method is used by many signals to stop the grid execution.
func _on_stop():
	ordered_output_view.init(null, grid.expected_output)
	grid_execution_view.queue_free()
	grid_execution_view = null
	StopButton.disabled = true

func _on_back_to_menu_pressed() -> void:
	back.emit()
