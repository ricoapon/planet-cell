class_name EditGridScreen
extends Control

func init(grid: Grid):
	var edit_ordered_output_view = $VBoxContainer/ExpectedSidePanel/VBoxContainer/MarginContainer/VBoxContainer/EditOrderedOutputView
	edit_ordered_output_view.init(null, grid.expected_output)
	$GridView.init(grid)

# TODO: remove after testing
func _ready():
	init(Grid.new(5, 5))
