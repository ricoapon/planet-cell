# We use a ColorRect because:
# 1. We can easily catch mouse events on the sprite (which doesn't have a click event, but ColorRect does).
# 2. We can scale the size of the ColorRect and Sprite2D will automatically scale with it.
# 3. For debugging, we can give it a color (instead of transparent) so we can see what is happening.
extends ColorRect
class_name Block

const ACTUAL_SIZE: float = 64
@export var grid_cell_size: int = 32
@export var grid_pos: Vector2i

func _ready():
	position = Vector2(grid_pos.x, grid_pos.y) * grid_cell_size
	scale = Vector2(grid_cell_size / ACTUAL_SIZE, grid_cell_size / ACTUAL_SIZE)

signal drag_start(grid_position: Vector2i)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		drag_start.emit(grid_pos)
