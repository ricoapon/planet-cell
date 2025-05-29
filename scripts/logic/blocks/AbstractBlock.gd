class_name AbstractBlock
extends RefCounted

func activate(_powered_edge: PoweredEdge, _out: Array[Edge]) -> Array[PoweredEdge]:
	push_error("activate() is not implemented in subclass!")
	return []

func get_output() -> SingleOutput:
	return SingleOutput.new()
