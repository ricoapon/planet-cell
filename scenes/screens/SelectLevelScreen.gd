class_name SelectLevelScreen
extends Control

@onready var levels_container = $VBoxContainer/LevelsContainer

signal go_to_level(int)
signal back

func _ready():
	for i in Level.all.size():
		levels_container.add_child(_create_level_button(i))

func _create_level_button(level_index: int) -> Button:
	var button = Button.new()
	# Humans normally count starting from 0.
	button.text = str(level_index + 1)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.pressed.connect(func(): go_to_level.emit(level_index))
	return button

func _on_back_button_pressed() -> void:
	back.emit()
