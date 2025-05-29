class_name SplitBlock
extends AbstractBlock

func activate(poweredEdge: PoweredEdge, out: Array[Edge]) -> Array[PoweredEdge]:
	return out.map(func(e): return e.power(poweredEdge.power))
