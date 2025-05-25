package public

import kotlinx.browser.document
import org.w3c.dom.HTMLElement
import private.Cell
import private.CellType

fun cellToHtml(cell: Cell?, isActive: Boolean): HTMLElement {
    val div = document.createElement("div") as HTMLElement
    div.classList.add("cell")

    if (cell == null) {
        return div
    }

    when(cell.type) {
        CellType.START -> div.classList.add("start")
        CellType.BLOCK -> div.classList.add("block")
        CellType.OUTPUT_O -> {
            div.classList.add("output")
            div.textContent = "O"
        }
        CellType.OUTPUT_G -> {
            div.classList.add("output")
            div.textContent = "G"
        }
    }

    if (isActive) {
        div.classList.add("active")
    }

    return div
}
