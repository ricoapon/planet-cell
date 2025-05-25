@file:OptIn(ExperimentalJsExport::class)

package public

import kotlinx.browser.document
import kotlinx.browser.window
import org.w3c.dom.HTMLButtonElement
import org.w3c.dom.HTMLElement
import private.*
import kotlin.properties.Delegates

const val gridSize = 10
val grid = Grid(gridSize, gridSize)
var gridExecution: GridExecution? = null

// HTML elements.
val htmlGrid = document.getElementById("grid") as HTMLElement
val htmlOutput = document.getElementById("output") as HTMLElement
val htmlButtonPlay = document.getElementById("play") as HTMLButtonElement
val htmlButtonStop = document.getElementById("stop") as HTMLButtonElement

fun main() {
    setupGridData()
    renderGrid()
}

private fun renderGrid() {
    renderGridToHtml(htmlGrid, grid, gridExecution)
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

private fun addWord(word: String) {
    val output = document.getElementById("output") as HTMLElement
    val text = document.createElement("p")
    text.textContent = word
    output.appendChild(text)
}

var interval by Delegates.notNull<Int>()

@JsExport
fun play() {
    if (gridExecution == null) {
        gridExecution = GridExecution(grid)
        htmlOutput.innerHTML = ""
        htmlButtonPlay.disabled = true
        htmlButtonStop.disabled = false
    }

    val response = gridExecution!!.nextStep()
    if (response != null) {
        addWord(response)
    }

    renderGrid()
    if (gridExecution!!.isRunning()) {
        interval = window.setTimeout(handler = { play() }, 250)
    } else {
        stop()
    }
}

@JsExport
fun stop() {
    gridExecution = null
    window.clearInterval(interval)
    renderGrid()
    htmlButtonPlay.disabled = false
    htmlButtonStop.disabled = true
}
