class_name GridExecutionView
extends Control

var grid: Grid
var grid_execution: GridExecution
var grid_view: GridView

func init(_grid_view: GridView):
	grid_view = _grid_view
	grid = grid_view.grid
	grid_execution = GridExecution.new(grid)
	z_index = 3
	
	position = grid_view.position

func next_step():
	grid_execution.next_step()
	queue_redraw()

func _draw():
	for powered_edge in grid_execution.next_powered_edges:
		# Starting point is with edge null.
		if powered_edge.from == null:
			draw_circle(to_middle_vector(powered_edge.to.x, powered_edge.to.y), 10, Color.RED)
			continue
		
		var x = powered_edge.from.x
		var y = powered_edge.from.y
		if powered_edge.from.x == powered_edge.to.x:
			if powered_edge.from.y < powered_edge.to.y:
				y += powered_edge.step
			else:
				y -= powered_edge.step
		else:
			if powered_edge.from.x < powered_edge.to.x:
				x += powered_edge.step
			else:
				x -= powered_edge.step
		
		var middle = to_middle_vector(x, y)
		draw_circle(middle, 10, Color.RED)
		
		# TODO: Find a better way to display power.
		draw_string(get_theme_default_font(), middle, str(powered_edge.power))

func to_middle_vector(x: int, y: int) -> Vector2:
	return GridCalculations.determine_middle(Coordinate.new(x, y), grid_view.CELL_SIZE, grid_view.spacing)
