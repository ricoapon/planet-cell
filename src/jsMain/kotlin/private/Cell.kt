package private

enum class CellType {
    START,
    BLOCK,
    OUTPUT_O,
    OUTPUT_G,
}

data class Cell(var type: CellType)
