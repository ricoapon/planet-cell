class_name OrderedOutputView
extends VBoxContainer

@onready var SingleOutputViewScene = preload("res://scenes/components/output/SingleOutputView.tscn")

var ordered_output: OrderedOutput

func init(_ordered_output):
	ordered_output = _ordered_output
	
	for output in ordered_output.outputs():
		var output_view: SingleOutputView = SingleOutputViewScene.instantiate()
		add_child(output_view)
		output_view.init(output)
		output_view.size = Vector2(100, 40)
