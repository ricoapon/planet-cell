class_name GridView
extends Control

@onready var BlockScene = preload("res://scenes/components/blocks/BlockView.tscn")

var grid: Grid
const CELL_SIZE = 64

var blocks: Dictionary[Coordinate, BlockView] = {}
var edge_views: EdgeViewDictionary = EdgeViewDictionary.new()

# Variables for the boxes.
var spacing = 6
var corner_radius = 6

func create_style_box_flat() -> StyleBoxFlat:
	var style_box_flat: StyleBoxFlat = StyleBoxFlat.new()
	style_box_flat.bg_color = Color.html("#D3D3D3")
	style_box_flat.corner_radius_top_left = corner_radius
	style_box_flat.corner_radius_top_right = corner_radius
	style_box_flat.corner_radius_bottom_left = corner_radius
	style_box_flat.corner_radius_bottom_right = corner_radius
	style_box_flat.set_corner_detail(10)
	return style_box_flat

func init(_grid: Grid):
	_init_grid(_grid)
	# Make sure the grid is the size we need for drag and drop stuff.
	size = Vector2(grid.width * (CELL_SIZE + spacing), grid.height * (CELL_SIZE + spacing))
	queue_redraw()

# The methods in this class assume we start with an empty grid. So we have to "rebuild"
# the grids using the methods.
func _init_grid(old_grid: Grid):
	grid = Grid.new(old_grid.width, old_grid.height)
	for coordinate in old_grid.coordinates.values():
		place_block(coordinate, old_grid.getBlock(coordinate))
	for edge in old_grid.edges.edges.values():
		add_edge(edge.from, edge.to)
	# We want to keep the same reference, so we use the old grid.
	grid = old_grid

func _draw():
	if grid == null:
		return

	var style_box_flat = create_style_box_flat()
	for x in grid.width:
		for y in grid.height:
			var pos = Vector2(x * (CELL_SIZE + spacing), y * (CELL_SIZE + spacing))
			var rect = Rect2(pos, Vector2(CELL_SIZE, CELL_SIZE))
			draw_style_box(style_box_flat, rect)

func place_block(coordinate: Coordinate, block: AbstractBlock):
	if not grid.can_add_block(coordinate):
		return
	
	var block_scene: BlockView = BlockScene.instantiate()
	block_scene.init(coordinate, block)
	
	# The block is slightly smaller than the drawn blocks. So we need some calculations.
	var top_left = Vector2(coordinate.x, coordinate.y) * (CELL_SIZE + spacing)
	var extra = (CELL_SIZE - block_scene.ACTUAL_SIZE) / 2.0
	var top_left_adjusted = top_left + Vector2(extra, extra)
	block_scene.position = top_left_adjusted
	
	grid.add_block(coordinate, block)
	$BlockContainer.add_child(block_scene)
	blocks[coordinate] = block_scene
	block_scene.connect("drag_start", on_start_block_drag)
	block_scene.connect("erase_me", on_erase_block)
	block_scene.z_index = 2

func _can_drop_data(_at_position, data):
	return data is AbstractBlock

func _drop_data(at_position, data):
	var x = floor(float(at_position.x) / (CELL_SIZE + spacing))
	var y = floor(float(at_position.y) / (CELL_SIZE + spacing))
	place_block(Coordinate.new(x, y), data)

func on_erase_block(coordinate: Coordinate):
	var block_scene = blocks[coordinate]
	block_scene.queue_free()
	blocks.erase(coordinate)
	grid.erase_block(coordinate)
	for edge in grid.neighbours(coordinate):
		var edge_view = edge_views.get_edge_view(edge.from, edge.to)
		on_erase_edge(edge_view)

func on_erase_edge(edge: EdgeView):
	grid.erase_edge(grid.get_edge(edge.from, edge.to))
	edge_views.erase_edge(edge)
	edge.queue_free()

var start_drag_coordinate = null

func on_start_block_drag(coordinate: Coordinate):
	start_drag_coordinate = coordinate

func _input(event):
	# If dragging:
	if start_drag_coordinate != null and event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()

		# Find block under mouse
		for coordinate in blocks.keys():
			var block = blocks[coordinate]
			if block.get_global_rect().has_point(mouse_pos):
				add_edge(start_drag_coordinate, coordinate)
				break
		start_drag_coordinate = null

func add_edge(from: Coordinate, to: Coordinate):
	# It can happen that the UI wants to draw from a block to itself.
	# Obviously, we don't want this.
	if (from.equals(to)):
		return
	
	# We also only allow horizontal or vertical lines.
	if from.x != to.x and from.y != to.y:
		return
	
	# Do not allow adding an edge that goes through a block.
	if not grid.can_add_edge(from, to):
		return
	
	grid.add_edge(from, to)
	var edge = EdgeView.new(from, to, CELL_SIZE, spacing)
	edge.z_index = 1
	$EdgeContainer.add_child(edge)
	edge_views.add(edge)
	edge.connect("erase_me", on_erase_edge)
