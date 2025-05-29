extends Control

@onready var BlockScene = preload("res://scenes/components/blocks/BlockView.tscn")

@export var width_in_pixels: int = 480
@export var height_in_pixels: int = 480

var width_in_cells = floor(float(width_in_pixels) / CELL_SIZE)
var height_in_cells = floor(float(height_in_pixels) / CELL_SIZE)
const CELL_SIZE = 32

var grid: Grid = Grid.new(10, 10)

var blocks: Dictionary[Coordinate, BlockView] = {}
var edge_views: EdgeViewDictionary = EdgeViewDictionary.new()

func _ready():
	# Make sure the grid is the size we need for drag and drop stuff.
	size = Vector2(width_in_pixels, height_in_pixels)

func _draw():
	draw_rect(Rect2i(0, 0, width_in_pixels, height_in_pixels), Color.html("#C5C9CC"))
	
	for x in (width_in_cells + 1):
		var from = Vector2i(x * CELL_SIZE, 0)
		var to = Vector2i(from.x, height_in_pixels)
		draw_line(from, to, Color.html("#AEB2B5"))
	for y in (height_in_cells + 1):
		var from = Vector2i(0, y * CELL_SIZE)
		var to = Vector2i(width_in_pixels, from.y)
		draw_line(from, to, Color.html("#AEB2B5"))

func place_block(coordinate: Coordinate, block: AbstractBlock):
	var block_scene = BlockScene.instantiate()
	block_scene.init(coordinate, CELL_SIZE, block)
	grid.setBlock(coordinate, block)
	add_child(block_scene)
	blocks[coordinate] = block_scene
	block_scene.connect("drag_start", on_start_block_drag)
	block_scene.connect("erase_me", on_erase_block)
	block_scene.z_index = 2

func _can_drop_data(_at_position, data):
	return data is AbstractBlock

func _drop_data(at_position, data):
	var x = floor(float(at_position.x) / CELL_SIZE)
	var y = floor(float(at_position.y) / CELL_SIZE)
	place_block(Coordinate.new(x, y), data)

func on_erase_block(coordinate: Coordinate):
	var block_scene = blocks[coordinate]
	block_scene.queue_free()
	blocks.erase(coordinate)
	grid.erase_block(coordinate)
	for edge in grid.neighbours(coordinate):
		grid.erase_edge(edge)
		var edge_view = edge_views.get_edge_view(edge.from, edge.to)
		if edge_view != null:
			on_erase_edge(edge_view)

func on_erase_edge(edge: EdgeView):
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
	
	grid.add_edge(from, to)
	var edge = EdgeView.new(from, to, CELL_SIZE)
	edge.z_index = 1
	add_child(edge)
	edge_views.add(edge)
