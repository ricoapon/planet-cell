class_name PlayGridScreen
extends Control

var grid: Grid

func init(_grid: Grid):
	grid = _grid
	var ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/OrderedOutputView
	ordered_output_view.init(null, grid.expected_output)
	$GridView.init(grid)

signal go_to_editor(grid: Grid)

func _on_editor_button_pressed() -> void:
	go_to_editor.emit(grid)
