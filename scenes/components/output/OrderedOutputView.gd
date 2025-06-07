class_name OrderedOutputView
extends VBoxContainer

@onready var SingleOutputViewScene = preload("res://scenes/components/output/SingleOutputView.tscn")

var actual_ordered_output: OrderedOutput
var expected_ordered_output: OrderedOutput

func init(_actual_ordered_output: OrderedOutput, _expected_ordered_output: OrderedOutput):
	# When we initialise again with new data, we want to override all the data.
	# We need to remove all children.
	_remove_all_children()
	
	expected_ordered_output = _expected_ordered_output
	# This happens on the edit screen.
	if _actual_ordered_output != null:
		actual_ordered_output = _actual_ordered_output
	else:
		actual_ordered_output = OrderedOutput.new()
	
	for i in expected_ordered_output.outputs().size():
		var actual_output = null
		if actual_ordered_output.outputs().size() > i:
			actual_output = actual_ordered_output.outputs()[i]
		add_child_output(actual_output, expected_ordered_output.outputs()[i])

func _remove_all_children():
	for i in get_children().size():
		get_children()[i].queue_free()

func add_child_output(actual_output: SingleOutput, expected_output: SingleOutput):
	var output_view: SingleOutputView = SingleOutputViewScene.instantiate()
	add_child(output_view)
	output_view.init(actual_output, expected_output)
	output_view.size = Vector2(100, 40)
