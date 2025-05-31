class_name EditGridScreen
extends Control

func _ready():
	var ordered_output = OrderedOutput.new()
	var edit_ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/EditOrderedOutputView
	edit_ordered_output_view.init(null, ordered_output)
