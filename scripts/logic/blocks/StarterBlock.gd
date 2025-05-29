class_name StarterBlock
extends AbstractBlock

func activate(poweredEdge: PoweredEdge, out: Array[Edge]) -> Array[PoweredEdge]:
	# If any power comes back, we stop. But this method is also called on the first activation, which
	# should continue. We can differentiate these situations by checking if from is null. This should
	# only happen on the first activation.
	if poweredEdge.from != null:
		return []
	return out.map(func(e): return e.power(1))

func type() -> Type:
	return Type.STARTER
