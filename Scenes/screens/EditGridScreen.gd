class_name EditGridScreen
extends Control

var grid: Grid

func init(_grid: Grid):
	grid = _grid
	var edit_ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/EditOrderedOutputView
	edit_ordered_output_view.init(null, grid.expected_output)
	$GridView.init(grid)

signal go_to_play_screen(grid: Grid)

func _on_play_button_pressed() -> void:
	if grid.expected_output._rows.size() == 0 || grid.expected_output._rows[0].equals(SingleOutput.new()):
		var popup: AcceptDialog = $AcceptDialog
		popup.dialog_text = "You need to add expected output!"
		popup.popup_centered()
		return
	go_to_play_screen.emit(grid)
