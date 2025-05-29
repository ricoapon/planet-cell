class_name BlockTextures

static var BLOCK_TEXTURE: Dictionary[AbstractBlock.Type, Texture2D] = {
	AbstractBlock.Type.STARTER: preload("res://assets/blocks/environment_04.png"),
	AbstractBlock.Type.OUTPUT: preload("res://assets/blocks/environment_01.png"),
	AbstractBlock.Type.SPLIT: preload("res://assets/blocks/environment_07.png")
}

static func get_texture_for_block(block: AbstractBlock) -> Texture2D:
	for type in BLOCK_TEXTURE.keys():
		if block.type() == type:
			return BLOCK_TEXTURE[type]
	push_error("Could not find texture for block ", block.type())
	return null

static func get_texture_for_type(type: AbstractBlock.Type) -> Texture2D:
	return BLOCK_TEXTURE[type]
