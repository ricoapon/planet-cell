class_name OrderedOutputView
extends VBoxContainer

@onready var SingleOutputViewScene = preload("res://scenes/components/output/SingleOutputView.tscn")

var actual_ordered_output: OrderedOutput
var expected_ordered_output: OrderedOutput

func init(_actual_ordered_output: OrderedOutput, _expected_ordered_output: OrderedOutput):
	expected_ordered_output = _expected_ordered_output
	# This happens on the edit screen.
	if _actual_ordered_output != null:
		actual_ordered_output = _actual_ordered_output
	else:
		actual_ordered_output = OrderedOutput.new()
	
	for i in expected_ordered_output.outputs().size():
		var output_view: SingleOutputView = SingleOutputViewScene.instantiate()
		add_child(output_view)
		output_view.init(actual_ordered_output.outputs()[i], expected_ordered_output.outputs()[i])
		output_view.size = Vector2(100, 40)
