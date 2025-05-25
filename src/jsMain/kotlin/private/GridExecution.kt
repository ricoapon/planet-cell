package private

data class Activation(val from: Coordinate, val current: Coordinate)

class GridExecution(private val grid: Grid ) {
    private var showAsActive: Set<Coordinate>
    private var nextActivations: MutableList<Activation>

    init {
        nextActivations = grid.getCellsOfType(CellType.START)
            .map { Activation(Coordinate(-1000, -1000), it) }.toMutableList()

        // Fill it with some coordinate to indicate we are running.
        showAsActive = setOf(Coordinate(-1000, -1000))
    }

    fun nextStep(): String? {
        val newNextActivations = mutableListOf<Activation>()
        val outputs = mutableListOf<String>()

        showAsActive = nextActivations.map { it.current }.toSet()

        for (activation in nextActivations) {
            val currentCoordinate = Coordinate(activation.current.x, activation.current.y)
            val currentCell = grid.getCell(currentCoordinate)!!

            // Any action that comes back to start (and is not the first action) should just stop.
            if (currentCell.type == CellType.START && activation.from.x >= 0) {
                continue
            }

            if (currentCell.type.name.startsWith("OUTPUT")) {
                outputs.add(currentCell.type.name)

                // We stop execution after it landed on an output.
                continue
            }

            newNextActivations.addAll(
                grid.getOrthogonalNeighbours(currentCoordinate)
                    .filter { it != activation.from }
                    .map { Activation(currentCoordinate, it) }
            )
        }

        nextActivations = newNextActivations

        if (outputs.isEmpty()) {
            return null
        }
        return outputs.joinToString("") { it.substringAfter('_')}
    }

    fun isActive(coordinate: Coordinate): Boolean {
        return showAsActive.contains(coordinate)
    }

    fun isRunning(): Boolean {
        return showAsActive.isNotEmpty()
    }
}
