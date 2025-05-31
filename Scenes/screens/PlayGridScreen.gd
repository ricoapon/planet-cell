class_name PlayGridScreen
extends Control

func init(grid: Grid):
	var ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/OrderedOutputView
	ordered_output_view.init(null, grid.expected_output)
	$GridView.init(grid)

# TODO: remove after testing
func _ready():
	init(Grid.new(5, 5))
