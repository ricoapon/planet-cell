package public

import org.w3c.dom.HTMLElement
import private.Coordinate
import private.Grid
import private.GridExecution

fun renderGridToHtml(htmlGrid: HTMLElement, grid: Grid, gridExecution: GridExecution? = null, onClick: (coordinate: Coordinate) -> Unit = {}) {
    htmlGrid.innerHTML = ""
    for (y in 0 until grid.height) {
        for (x in 0 until grid.width) {
            val coordinate = Coordinate(x, y)
            val cell = grid.getCell(coordinate)
            val div = cellToHtml(cell, gridExecution?.isActive(coordinate) ?: false)
            div.onclick = { onClick(coordinate) }
            htmlGrid.appendChild(div)
        }
    }
}
