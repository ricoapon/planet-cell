package public.pages

import kotlinx.browser.document
import kotlinx.browser.window
import org.w3c.dom.HTMLElement
import org.w3c.dom.HTMLInputElement
import org.w3c.dom.url.URLSearchParams
import org.w3c.dom.HTMLTextAreaElement
import private.Cell
import private.CellType
import private.Coordinate
import private.Grid
import public.renderGridToHtml

@OptIn(ExperimentalJsExport::class)
@JsExport
object Creator {
    private var grid = Grid(10, 10)
    private val htmlGrid = document.getElementById("grid") as HTMLElement
    private val htmlCode = document.getElementById("code") as HTMLElement
    private val htmlOutput = document.getElementById("output") as HTMLTextAreaElement

    fun main() {
        val urlParams = URLSearchParams(window.location.search)
        if (urlParams.has("code")) {
            grid = Grid.createFromCode(urlParams.get("code")!!)
        }

        renderGrid()
    }

    private fun renderGrid() {
        renderGridToHtml(htmlGrid, grid, null, onClick = { squareClicked(it.x, it.y) })
        grid.setOutput(htmlOutput.innerText.trim('\n').split("\n"))
        console.log("Setting output to ", htmlOutput.innerHTML)
        htmlCode.textContent = grid.convertToCode()
    }

    private fun determineCell(): Cell? {
        val cellTypeAsString = (document.querySelector("input[name=\"cell_type\"]:checked") as HTMLInputElement).value
        if (cellTypeAsString == "EMPTY") {
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

    fun play() {
        window.location.href = "/?code=${grid.convertToCode()}"
    }

    fun clear() {
        window.location.href = "/creator.html"
    }
}
