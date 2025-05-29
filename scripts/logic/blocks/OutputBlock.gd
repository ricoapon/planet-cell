class_name OutputBlock
extends AbstractBlock

var output: SingleOutput

var color: SingleOutput.OutputColor

func _init(_color: SingleOutput.OutputColor):
	color = _color

func activate(powered_edge: PoweredEdge, _out: Array[Edge]) -> Array[PoweredEdge]:
	output = SingleOutput.new()
	output.add_color(color, powered_edge.power)
	return []

func get_output() -> SingleOutput:
	return output

func type() -> Type:
	return Type.OUTPUT
