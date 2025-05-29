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
