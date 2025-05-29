extends Control

@onready var BlockScene = preload("res://scenes/components/blocks/BlockView.tscn")

@export var width_in_pixels: int = 480
@export var height_in_pixels: int = 480

var width_in_cells = floor(float(width_in_pixels) / CELL_SIZE)
var height_in_cells = floor(float(height_in_pixels) / CELL_SIZE)
const CELL_SIZE = 32

var grid = Grid.new(10, 10)

var blocks = {}

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
	block_scene.z_index = 2

func _can_drop_data(_at_position, data):
	return data is AbstractBlock

func _drop_data(at_position, data):
	var x = floor(float(at_position.x) / CELL_SIZE)
	var y = floor(float(at_position.y) / CELL_SIZE)
	place_block(Coordinate.new(x, y), data)


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
				add_line(start_drag_coordinate, coordinate)
				break
		start_drag_coordinate = null

func add_line(from: Coordinate, to: Coordinate):
	var line = Line2D.new()
	line.z_index = 1
	line.default_color = Color.RED
	line.width = 4
	var from_middle = (Vector2(from.x + 0.5, from.y + 0.5)) * CELL_SIZE
	var to_middle = (Vector2(to.x + 0.5, to.y + 0.5)) * CELL_SIZE
	line.add_point(from_middle)
	line.add_point(to_middle)
	add_child(line)
