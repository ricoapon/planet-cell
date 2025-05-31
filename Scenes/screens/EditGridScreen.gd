extends Control

func _ready():
	var row1 = SingleOutput.new()
	row1.add_color(SingleOutput.OutputColor.GREEN, 1)
	row1.add_color(SingleOutput.OutputColor.RED, 2)
	var row2 = SingleOutput.new()
	row2.add_color(SingleOutput.OutputColor.BLUE, 4)
	var ordered_output = OrderedOutput.new()
	ordered_output.next_row()
	ordered_output.add_output_to_current_row(row1)
	ordered_output.next_row()
	ordered_output.add_output_to_current_row(row2)
	var ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/OrderedOutputView
	ordered_output_view.init(ordered_output, ordered_output)
