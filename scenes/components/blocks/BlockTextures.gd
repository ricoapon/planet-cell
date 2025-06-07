# Later on I should use actual textures. For now, I will just color it.
class_name BlockTextures
extends RefCounted

const CORNER_RADIUS = 5

static func get_theme(block: AbstractBlock) -> StyleBoxFlat:
	var style_box_flat: StyleBoxFlat = StyleBoxFlat.new()
	style_box_flat.corner_radius_top_left = CORNER_RADIUS
	style_box_flat.corner_radius_top_right = CORNER_RADIUS
	style_box_flat.corner_radius_bottom_left = CORNER_RADIUS
	style_box_flat.corner_radius_bottom_right = CORNER_RADIUS
	style_box_flat.set_corner_detail(10)

	match block.type():
		AbstractBlock.Type.STARTER:
			style_box_flat.bg_color = Color.BLACK
		AbstractBlock.Type.SPLIT:
			style_box_flat.bg_color = Color.BLACK
		AbstractBlock.Type.OUTPUT:
			var output_block: OutputBlock = block
			style_box_flat.bg_color = SingleColorView.OUTPUT_TO_COLOR[output_block.color]

	return style_box_flat

static func get_text(block_type: AbstractBlock.Type) -> String:
	match block_type:
		AbstractBlock.Type.STARTER:
			return "S"
		AbstractBlock.Type.SPLIT:
			return "+"
		AbstractBlock.Type.OUTPUT:
			return "O"
		_:
			push_error("Found block type that is not updated in enum", block_type)
			return "X"
