extends TextureRect

func _get_drag_data(_at_position: Vector2):
	var preview = self.duplicate()
	
	var c = Control.new()
	c.add_child(preview)
	preview.position = Vector2(-32, -32)
	preview.modulate = Color(1, 1, 1, 0.8)

	set_drag_preview(c)
	# The data must be the model of the block.
	return SplitBlock.new()
