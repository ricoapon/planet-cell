class_name EditSingleOutputView
extends SingleOutputView

@onready var EditSingleColorViewScene = preload("res://scenes/components/output/EditSingleColorView.tscn")

func init(_actual_output: SingleOutput, _expected_output: SingleOutput):
	SingleColorViewScene = EditSingleColorViewScene
	super.init(null, _expected_output)
	
	for edit_single_color_view: EditSingleColorView in get_children():
		edit_single_color_view.connect("change_times", _on_change_times)

func _should_show_color(_color) -> bool:
	return true

func _on_change_times(output_color: SingleOutput.OutputColor, delta: int):
	expected_output.add_color(output_color, delta)
