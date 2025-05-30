class_name SplitBlock
extends AbstractBlock

func activate(poweredEdge: PoweredEdge, out: Array[Edge]) -> Array[PoweredEdge]:
	var result: Array[PoweredEdge] = []
	result.assign(out.map(func(e: Edge): return e.to_powered_edge(poweredEdge.power)))
	return result

func type() -> Type:
	return Type.SPLIT
