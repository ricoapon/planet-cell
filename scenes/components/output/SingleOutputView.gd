class_name SingleOutputView
extends HBoxContainer

@onready var SingleColorViewScene = preload("res://scenes/components/output/SingleColorView.tscn")

var actual_output: SingleOutput
var expected_output: SingleOutput

func init(_actual_output: SingleOutput, _expected_output: SingleOutput):
	expected_output = _expected_output
	# It can be that there is no actual output yet, so we deal with that without problems.
	if _actual_output != null:
		actual_output = _actual_output
	else:
		actual_output = SingleOutput.new()
	
	custom_minimum_size = Vector2(100, 40)
	for color in SingleOutput.OutputColor.values():
		if _should_show_color(color):
				var view: SingleColorView = SingleColorViewScene.instantiate()
				add_child(view)
				view.init(color, actual_output.times_color_is_present(color), expected_output.times_color_is_present(color))
	
	if not get_children().is_empty():
		(get_child(0) as SingleColorView).use_rounded_corners_left()
		(get_child(-1) as SingleColorView).use_rounded_corners_right()

func _should_show_color(color) -> bool:
	return expected_output.times_color_is_present(color) > 0
