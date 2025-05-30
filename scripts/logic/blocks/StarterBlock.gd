class_name StarterBlock
extends AbstractBlock

func activate(powered_edge: PoweredEdge, out: Array[Edge]) -> Array[PoweredEdge]:
	# If any power comes back, we stop. But this method is also called on the first activation, which
	# should continue. We can differentiate these situations by checking if from is null. This should
	# only happen on the first activation.
	if powered_edge.from != null:
		return []
		
	# To work around typing issues with map, we do this.
	var result: Array[PoweredEdge]
	result.assign(out.map(func(e): return e.to_powered_edge(1)))
	return result

func type() -> Type:
	return Type.STARTER
