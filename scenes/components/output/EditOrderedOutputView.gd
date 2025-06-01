class_name EditOrderedOutputView
extends OrderedOutputView

@onready var EditSingleOutputViewScene = preload("res://scenes/components/output/EditSingleOutputView.tscn")

func init(_actual_ordered_output: OrderedOutput, _expected_ordered_output: OrderedOutput):
	SingleOutputViewScene = EditSingleOutputViewScene
	super.init(null, _expected_ordered_output)
	move_button_down()

func move_button_down():
	move_child($AddRow, get_child_count() - 1)


func _on_add_row_pressed() -> void:
	var new_output = SingleOutput.new()
	expected_ordered_output._rows.append(new_output)
	add_child_output(null, new_output)
	move_button_down()
