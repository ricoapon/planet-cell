package org.example

import kotlinx.browser.document
import org.w3c.dom.HTMLElement

data class Cell(var type: String = "empty", val connections: MutableList<Pair<Int, Int>> = mutableListOf())

const val gridSize = 10
val gridData = Array(gridSize) { Array(gridSize) { Cell() } }

fun main() {
    setupGridData()
    renderGrid()

    // Expose reset function to JS
    js("window.resetConnections = function() { org.example.resetConnections(); }")
}

fun setupGridData() {
    gridData[2][2].type = "start"
    gridData[2][3].type = "block"
    gridData[2][4].type = "output"
    gridData[3][4].type = "block"
    gridData[4][4].type = "output"

    gridData[2][2].connections += Pair(0, 1)
    gridData[2][3].connections += Pair(0, 1)
    gridData[2][4].connections += Pair(1, 0)
    gridData[3][4].connections += Pair(1, 0)
}

fun renderGrid() {
    val grid = document.getElementById("grid") as HTMLElement
    grid.innerHTML = ""
    for (y in 0 until gridSize) {
        for (x in 0 until gridSize) {
            val cell = gridData[y][x]
            val div = document.createElement("div") as HTMLElement
            div.classList.add("cell")
            if (cell.type != "empty") div.classList.add(cell.type)
            for ((dy, dx) in cell.connections) {
                val conn = document.createElement("div") as HTMLElement
                conn.classList.add("connection")
                if (dy == 0 && dx == 1) conn.classList.add("horizontal")
                if (dy == 1 && dx == 0) conn.classList.add("vertical")
                div.appendChild(conn)
            }
            grid.appendChild(div)
        }
    }
}

fun resetConnections() {
    for (row in gridData) {
        for (cell in row) {
            cell.connections.clear()
        }
    }
    setupGridData()
    renderGrid()
}
