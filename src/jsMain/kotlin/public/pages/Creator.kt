package public.pages

import kotlinx.browser.document
import org.w3c.dom.HTMLElement
import org.w3c.dom.HTMLInputElement
import private.Cell
import private.CellType
import private.Coordinate
import private.Grid
import public.renderGridToHtml

@OptIn(ExperimentalJsExport::class)
@JsExport
object Creator {
    private val grid = Grid(10, 10)
    private val htmlGrid = document.getElementById("grid") as HTMLElement

    fun main() {
        renderGrid()
    }

    private fun renderGrid() {
        renderGridToHtml(htmlGrid, grid, null, onClick = { squareClicked(it.x, it.y) })
    }

    private fun determineCell(): Cell? {
        val cellTypeAsString = (document.querySelector("input[name=\"rate\"]:checked") as HTMLInputElement).value
        if (cellTypeAsString == "empty") {
            return null
        }
        return Cell(CellType.valueOf(cellTypeAsString))
    }

    private fun squareClicked(x: Int, y: Int) {
        val cell = determineCell()
        val coordinate = Coordinate(x, y)
        if (cell == null) {
            grid.clearCell(coordinate)
        } else {
            grid.setCell(coordinate, cell)
        }

        renderGrid()
    }
}
