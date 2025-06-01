class_name AbstractBlock
extends RefCounted

enum Type {
	OUTPUT,
	SPLIT,
	STARTER
}

func activate(_powered_edge: PoweredEdge, _out: Array[Edge]) -> Array[PoweredEdge]:
	push_error("activate() is not implemented in subclass!")
	return []

func get_output() -> SingleOutput:
	return SingleOutput.new()

func type() -> Type:
	push_error("type() should be implemented in subclass!")
	return Type.STARTER

func to_dict() -> Dictionary:
	return {
		"type" : type()
	}

static func from_dict(data: Dictionary) -> AbstractBlock:
	match AbstractBlock.Type.values()[data["type"]]:
		Type.OUTPUT:
			return OutputBlock.new(data["color"])
		Type.SPLIT:
			return SplitBlock.new()
		Type.STARTER:
			return StarterBlock.new()
		_:
			push_error("Type not found when converting dictionary to AbstractBlock: ", data["type"])
			return AbstractBlock.new()
