package private

data class Coordinate(val x: Int, val y: Int)

class Grid(private val width: Int, private val height: Int) {
    private val cells = mutableMapOf<Coordinate, Cell>()

    fun setCell(coordinate: Coordinate, cell: Cell) {
        cells[coordinate] = cell
    }

    fun getCell(coordinate: Coordinate): Cell? {
        return cells[coordinate]
    }

    fun getOrthogonalNeighbours(c: Coordinate): List<Coordinate> {
        return listOf(
            Coordinate(c.x + 1, c.y),
            Coordinate(c.x - 1, c.y),
            Coordinate(c.x, c.y + 1),
            Coordinate(c.x, c.y - 1),
        ).asSequence()
            .filter { n -> n.x >= 0 }
            .filter { n -> n.y >= 0 }
            .filter { n -> n.x < width }
            .filter { n -> n.y < height }
            .filter { n -> cells.contains(n) }
            .toList()
    }

    fun getCellsOfType(type: CellType): List<Coordinate> {
        return cells.filter { it.value.type == type }.map { it.key }
    }
}
