package org.example

import kotlinx.browser.document
import kotlinx.browser.window
import org.w3c.dom.HTMLElement

enum class CellType(val cssClass: String) {
    EMPTY("empty"),
    START("start"),
    BLOCK("block"),
    OUTPUT_ORANGE("output-orange"),
    OUTPUT_GREEN("output-green")
    ;
}

data class Cell(var type: CellType = CellType.EMPTY)

const val gridSize = 10
val gridData = Array(gridSize) { Array(gridSize) { Cell() } }

fun main() {
    setupGridData()
    renderGrid()
}

private fun setupGridData() {
    gridData[2][2] = Cell(CellType.START)
    gridData[2][3] = Cell(CellType.BLOCK)
    gridData[2][4] = Cell(CellType.OUTPUT_ORANGE)
    gridData[3][4] = Cell(CellType.BLOCK)
    gridData[4][4] = Cell(CellType.OUTPUT_GREEN)

    gridData[3][2] = Cell(CellType.BLOCK)
    gridData[4][2] = Cell(CellType.OUTPUT_GREEN)
}

private fun renderGrid() {
    val grid = document.getElementById("grid") as HTMLElement
    grid.innerHTML = ""
    for (y in 0 until gridSize) {
        for (x in 0 until gridSize) {
            val cell = gridData[y][x]
            val div = document.createElement("div") as HTMLElement
            div.classList.add("cell")
            div.classList.add(cell.type.cssClass)
            if (isActive(x, y)) {
                div.classList.add("active")
            }
            grid.appendChild(div)
        }
    }
}

fun isActive(x: Int, y: Int): Boolean {
    return showAsActive.any { it.x == x && it.y == y }
}

@OptIn(ExperimentalJsExport::class)
@JsExport
fun playAutomatically() {
    play()
    if (showAsActive.isNotEmpty()) {
        window.setTimeout(handler = { playAutomatically() }, 1000)
    }
}

data class Coordinate(val x: Int, val y: Int)

data class Activation(val from: Coordinate, val current: Coordinate)

var showAsActive = listOf<Coordinate>()
var nextActivations: MutableList<Activation> = mutableListOf(Activation(Coordinate(-1000, -1000), Coordinate(2, 2)))

fun play() {
    val newNextActivations = mutableListOf<Activation>()
    val outputs = mutableListOf<String>()

    showAsActive = nextActivations.map { it.current }

    for (activation in nextActivations) {
        val currentCoordinate = Coordinate(activation.current.x, activation.current.y)
        val currentCell = gridData[activation.current.y][activation.current.x]
        if (currentCell.type.name.startsWith("OUTPUT")) {
            outputs.add(currentCell.type.name)
        }

        for (neighbour in findNonEmptyOrthogonalNeighbours(activation.current.x, activation.current.y)) {
            if (neighbour != activation.from) {
                newNextActivations += Activation(currentCoordinate, neighbour)
            }
        }
    }

    if (outputs.isNotEmpty()) {
        val output = document.getElementById("output") as HTMLElement
        val text = document.createElement("p")
        text.textContent = outputs.joinToString()
        output.appendChild(text)
    }

    nextActivations = newNextActivations
    renderGrid()
}

private fun findNonEmptyOrthogonalNeighbours(x: Int, y: Int): List<Coordinate> {
    return listOf(
        Coordinate(x + 1, y),
        Coordinate(x - 1, y),
        Coordinate(x, y + 1),
        Coordinate(x, y - 1),
    )
        .filter { n -> n.x >= 0 }
        .filter { n -> n.y >= 0 }
        .filter { n -> n.x < gridSize }
        .filter { n -> n.y < gridSize }
        .filter { n -> gridData[n.y][n.x].type != CellType.EMPTY }
}
