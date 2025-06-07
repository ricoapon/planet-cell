extends Panel

@export var block_type: AbstractBlock.Type
# Only relevant when the block_type is OUTPUT.
@export var output_color: SingleOutput.OutputColor

func _ready():
	add_theme_stylebox_override("panel", BlockTextures.get_theme(_create_block_instance()))
	$Label.text = BlockTextures.get_text(block_type)

func _get_drag_data(_at_position: Vector2):
	var preview = self.duplicate()
	
	var c = Control.new()
	c.add_child(preview)
	preview.position = Vector2(-32, -32)
	preview.modulate = Color(1, 1, 1, 0.8)
	set_drag_preview(c)
	
	return _create_block_instance()

func _create_block_instance() -> AbstractBlock:
	match block_type:
		AbstractBlock.Type.STARTER:
			return StarterBlock.new()
		AbstractBlock.Type.SPLIT:
			return SplitBlock.new()
		AbstractBlock.Type.OUTPUT:
			return OutputBlock.new(output_color)
		_:
			push_error("Found block type that is not updated in enum", block_type)
			return null
