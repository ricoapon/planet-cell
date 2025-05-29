class_name BlockTextures

static var BLOCK_TEXTURE: Dictionary = {
	StarterBlock: preload("res://assets/blocks/environment_04.png"),
	OutputBlock: preload("res://assets/blocks/environment_01.png"),
	SplitBlock: preload("res://assets/blocks/environment_07.png")
}

static func get_texture_for_block(block: AbstractBlock) -> Texture2D:
	for clazz in BLOCK_TEXTURE.keys():
		if is_instance_of(block, clazz):
			return BLOCK_TEXTURE[clazz]
	push_error("Could not find texture for block " + block.get_class())
	return null
