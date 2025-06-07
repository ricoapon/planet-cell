class_name EditGridScreen
extends Control

@onready var ExportImportPopupScene = preload("res://scenes/components/popups/ExportImportPopup.tscn")

signal back

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


func _on_export_button_pressed() -> void:
	var export_import_popup: ExportImportPopup = ExportImportPopupScene.instantiate()
	add_child(export_import_popup)
	export_import_popup.init(GridCode.convert_to_code(grid))
	export_import_popup.load_grid.connect(_init_grid_code)
	export_import_popup.popup_centered()
	export_import_popup.show()

func _init_grid_code(code: String):
	var new_grid = GridCode.convert_to_grid(code)
	# Null means error situation.
	if new_grid != null:
		init(new_grid)

func _on_back_to_menu_pressed() -> void:
	back.emit()
