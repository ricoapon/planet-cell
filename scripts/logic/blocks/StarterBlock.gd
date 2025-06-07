class_name StarterBlock
extends AbstractBlock

func activate(_powered_edge: PoweredEdge, _out: Array[Edge]) -> Array[PoweredEdge]:
	# If any power comes back, we stop. Activating the first time is not done using
	# this method, so we don't need to take that into account.
	return []

func type() -> Type:
	return Type.STARTER
