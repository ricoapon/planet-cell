package public

import org.w3c.dom.HTMLElement
import private.Coordinate
import private.Grid
import private.GridExecution

fun renderGridToHtml(htmlGrid: HTMLElement, grid: Grid, gridExecution: GridExecution?) {
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
