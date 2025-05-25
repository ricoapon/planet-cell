package private

enum class CellType {
    START,
    BLOCK,
    OUTPUT_O,
    OUTPUT_G,
    STOP_AFTER_1,
}

data class Cell(var type: CellType)
