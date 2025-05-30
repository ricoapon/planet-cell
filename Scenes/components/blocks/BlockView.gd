# We use a ColorRect because:
# 1. We can easily catch mouse events on the sprite (which doesn't have a click event, but ColorRect does).
# 2. We can scale the size of the ColorRect and Sprite2D will automatically scale with it.
# 3. For debugging, we can give it a color (instead of transparent) so we can see what is happening.
extends ColorRect
class_name BlockView

const ACTUAL_SIZE: float = 64
var grid_cell_size: int
var coordinate: Coordinate
var block: AbstractBlock

func init(_coordinate: Coordinate, _grid_cell_size: int, _block: AbstractBlock):
	coordinate = _coordinate
	grid_cell_size = _grid_cell_size
	block = _block

func _ready():
	scale = Vector2(grid_cell_size / ACTUAL_SIZE, grid_cell_size / ACTUAL_SIZE)
	$Sprite2D.texture = BlockTextures.get_texture_for_block(block)

signal drag_start(coordinate: Coordinate)
signal erase_me(coordinate: Coordinate)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			erase_me.emit(coordinate)
		elif event.pressed:
			drag_start.emit(coordinate)
