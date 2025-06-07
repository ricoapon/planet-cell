class_name GridExecutionView
extends Control

var grid: Grid
var grid_execution: GridExecution
var grid_view: GridView
var ordered_output_view: OrderedOutputView

func init(_grid_view: GridView, _ordered_output_view: OrderedOutputView):
	grid_view = _grid_view
	ordered_output_view = _ordered_output_view
	grid = grid_view.grid
	grid_execution = GridExecution.new(grid)
	z_index = 3
	_update_output_view()

	position = grid_view.position

func _update_output_view():
	ordered_output_view.init(grid_execution.current_output, grid.expected_output)

func next_step():
	grid_execution.next_step()
	_update_output_view()
	queue_redraw()

func has_next_step() -> bool:
	return grid_execution.has_next_step()

func _draw():
	for active_coordinate in grid_execution.show_as_active.keys():
		var middle = to_middle_vector(active_coordinate)
		draw_circle(middle, 10, Color.RED)
		
		# TODO: Find a better way to display power.
		var power = grid_execution.show_as_active.get_value(active_coordinate)
		draw_string(get_theme_default_font(), middle, str(power))

func to_middle_vector(coordinate: Coordinate) -> Vector2:
	return GridCalculations.determine_middle(coordinate, grid_view.CELL_SIZE, grid_view.spacing)
