package private

import kotlin.io.encoding.Base64
import kotlin.io.encoding.ExperimentalEncodingApi

data class Coordinate(val x: Int, val y: Int)

class Grid(val width: Int, val height: Int) {
    private val cells = mutableMapOf<Coordinate, Cell>()

    fun clearCell(coordinate: Coordinate) {
        cells.remove(coordinate)
    }

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

    companion object {
        @OptIn(ExperimentalEncodingApi::class)
        fun createFromCode(codeBase64: String): Grid {
            val code = Base64.decode(codeBase64.encodeToByteArray()).decodeToString().split(";").toMutableList()
            val grid = Grid(code[0].toInt(), code[1].toInt())
            code.removeAt(0)
            code.removeAt(0)
            for (c in code) {
                val cellContent = c.split(",")
                val x = cellContent[0].toInt()
                val y = cellContent[1].toInt()
                val cellType = CellType.valueOf(cellContent[2])
                grid.setCell(Coordinate(x, y), Cell(cellType))
            }
            return grid
        }
    }

    @OptIn(ExperimentalEncodingApi::class)
    fun convertToCode(): String {
        var code = "$width;$height"
        if (cells.isNotEmpty()) {
            code += ";${cells.map { "${it.key.x},${it.key.y},${it.value.type.name}" }.joinToString(";")}"
        }
        return Base64.encode(code.encodeToByteArray())
    }
}
