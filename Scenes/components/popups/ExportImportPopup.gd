class_name ExportImportPopup
extends PopupPanel

@onready var text_edit = $VBoxContainer/HBoxCode/TextEdit

signal load_grid(value: String)

func init(value: String):
	text_edit.text = value

func _ready():
	self.popup_hide.connect(_on_cancel_pressed)

func _on_cancel_pressed() -> void:
	self.queue_free()

func _on_copy_pressed() -> void:
	DisplayServer.clipboard_set(text_edit.text)

func _on_paste_pressed() -> void:
	text_edit.text = DisplayServer.clipboard_get()

func _on_load_pressed() -> void:
	load_grid.emit(text_edit.text)
	_on_cancel_pressed()
