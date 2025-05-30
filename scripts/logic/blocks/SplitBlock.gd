class_name SplitBlock
extends AbstractBlock

func activate(powered_edge: PoweredEdge, out: Array[Edge]) -> Array[PoweredEdge]:
	var result: Array[PoweredEdge] = []
	result.assign(out.map(func(e: Edge): return e.to_powered_edge(powered_edge.power, powered_edge.to)))
	return result

func type() -> Type:
	return Type.SPLIT
