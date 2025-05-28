extends Control

@onready var BlockScene = preload("res://scenes/components/Block.tscn")
@onready var StartBlockScene = preload("res://scenes/components/StartBlock.tscn")

@export var width_in_pixels: int = 480
@export var height_in_pixels: int = 480

var width_in_cells = floor(float(width_in_pixels) / CELL_SIZE)
var height_in_cells = floor(float(height_in_pixels) / CELL_SIZE)
const CELL_SIZE = 32

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

	place_block(Vector2i(2, 2))
	place_block(Vector2i(2, 3))
	place_block(Vector2i(5, 5))

func place_block(pos: Vector2i):
	var block = BlockScene.instantiate()
	block.grid_pos = pos
	block.grid_cell_size = CELL_SIZE
	add_child(block)
	blocks[pos] = block

func _can_drop_data(_at_position, data):
	return data == "BlockType:Basic"

func _drop_data(at_position, _data):
	var x = floor(float(at_position.x) / CELL_SIZE)
	var y = floor(float(at_position.y) / CELL_SIZE)
	place_block(Vector2i(x, y))
