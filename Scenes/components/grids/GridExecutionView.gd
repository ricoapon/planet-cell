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
			draw_circle(to_vector(powered_edge.to.x, powered_edge.to.y), 10, Color.RED)
			continue
		
		var x = powered_edge.from.x
		var y = powered_edge.from.y
		if powered_edge.from.x == powered_edge.to.x:
			y += powered_edge.step
		else:
			x += powered_edge.step
		draw_circle(to_vector(x, y), 10, Color.RED)

func to_vector(x: int, y: int) -> Vector2:
	return Vector2(grid_view.CELL_SIZE * (x + 0.5), grid_view.CELL_SIZE * (y + 0.5))
