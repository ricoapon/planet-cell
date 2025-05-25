@file:OptIn(ExperimentalJsExport::class)

package public

import kotlinx.browser.document
import kotlinx.browser.window
import org.w3c.dom.HTMLElement
import private.*

const val gridSize = 10
val grid = Grid(gridSize, gridSize)
var gridExecution: GridExecution? = null

fun main() {
    setupGridData()
    renderGrid()
}

private fun setupGridData() {
    grid.setCell(Coordinate(2, 2), Cell(CellType.START))
    grid.setCell(Coordinate(2, 3), Cell(CellType.BLOCK))
    grid.setCell(Coordinate(2, 4), Cell(CellType.OUTPUT_O))
    grid.setCell(Coordinate(3, 4), Cell(CellType.BLOCK))
    grid.setCell(Coordinate(4, 4), Cell(CellType.OUTPUT_G))

    grid.setCell(Coordinate(3, 2), Cell(CellType.BLOCK))
    grid.setCell(Coordinate(4, 2), Cell(CellType.OUTPUT_G))
}

private fun renderGrid() {
    val htmlGrid = document.getElementById("grid") as HTMLElement
    htmlGrid.innerHTML = ""
    for (y in 0 until gridSize) {
        for (x in 0 until gridSize) {
            val coordinate = Coordinate(x, y)
            val cell = grid.getCell(coordinate)
            val div = cellToHtml(cell, gridExecution?.isActive(coordinate) ?: false)
            htmlGrid.appendChild(div)
        }
    }
}

private fun addWord(word: String) {
    val output = document.getElementById("output") as HTMLElement
    val text = document.createElement("p")
    text.textContent = word
    output.appendChild(text)
}

@JsExport
fun playAutomatically() {
    if (gridExecution == null) {
        gridExecution = GridExecution(grid)
    }

    val response = gridExecution!!.nextStep()
    if (response != null) {
        addWord(response)
    }

    renderGrid()
    if (gridExecution!!.isRunning()) {
        window.setTimeout(handler = { playAutomatically() }, 1000)
    } else {
        gridExecution = null
    }
}

@JsExport
fun stop() {
    gridExecution = null
}
