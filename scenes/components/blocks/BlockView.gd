# We use a Panel because:
# 1. We can easily catch mouse events on the sprite (which doesn't have a click event, but ColorRect does).
# 2. We can scale the size of the Panel and Sprite2D will automatically scale with it.
# 3. For debugging, we can give it a color (instead of transparent) so we can see what is happening.
extends Panel
class_name BlockView

const ACTUAL_SIZE = 48
var coordinate: Coordinate
var block: AbstractBlock

func init(_coordinate: Coordinate, _block: AbstractBlock):
	coordinate = _coordinate
	block = _block

func _ready():
	add_theme_stylebox_override("panel", BlockTextures.get_theme(block))
	$Label.text = BlockTextures.get_text(block.type())

signal drag_start(coordinate: Coordinate)
signal erase_me(coordinate: Coordinate)

func _gui_input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.double_click:
			erase_me.emit(coordinate)
		elif event.pressed:
			drag_start.emit(coordinate)
