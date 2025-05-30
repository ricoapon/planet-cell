class_name SingleOutputView
extends Control

@onready var SingleColorViewScene = preload("res://scenes/components/output/SingleColorView.tscn")

var output: SingleOutput

func init(_output: SingleOutput):
	output = _output
	custom_minimum_size = Vector2(100, 40)
	for color in SingleOutput.OutputColor.values():
		if output.times_color_is_present(color) > 0:
				var view = SingleColorViewScene.instantiate()
				$HBoxContainer.add_child(view)
				view.init(color, output.times_color_is_present(color))
