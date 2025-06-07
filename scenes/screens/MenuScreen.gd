class_name MenuScreen
extends Control

signal go_to_editor(grid: Grid)
signal go_to_select_level

func _on_editor_button_pressed() -> void:
	go_to_editor.emit(Grid.new(10, 10))

func _on_play_button_pressed() -> void:
	go_to_select_level.emit()
