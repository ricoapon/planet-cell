extends Node2D
class_name Block

const ACTUAL_SIZE: float = 64
@export var grid_cell_size: int = 32
@export var grid_pos: Vector2i

func _ready():
	# The variable grid_pos will give us the position of the top left of the square
	# we want to land it. We want to move to the middle of that square.
	position = Vector2(0.5 + grid_pos.x, 0.5 + grid_pos.y) * grid_cell_size
	
	$ColorRect.scale = Vector2(ACTUAL_SIZE / grid_cell_size, ACTUAL_SIZE / grid_cell_size)
	set_sprite_size($Sprite2D, Vector2(grid_cell_size * 0.75, grid_cell_size * 0.75))

func set_sprite_size(sprite: Sprite2D, desired_size: Vector2):
	if sprite.texture:
		var texture_size = sprite.texture.get_size()
		sprite.scale = desired_size / texture_size
