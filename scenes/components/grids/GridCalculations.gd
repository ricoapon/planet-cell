class_name GridCalculations
extends RefCounted

static func determine_middle(coordinate: Coordinate, cell_size, spacing) -> Vector2:
	return Vector2(
		(cell_size + spacing) * (coordinate.x + 0.5) - spacing / 2.0,
		(cell_size + spacing) * (coordinate.y + 0.5) - spacing / 2.0)
