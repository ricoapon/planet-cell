package private

data class Activation(val from: Coordinate, val current: Coordinate)

class GridExecution(private val grid: Grid) {
    private var showAsActive: Set<Coordinate>
    private var nextActivations: MutableList<Activation>
    private val stopAfter = mutableSetOf<Coordinate>()
    private val expectedOutput: List<String>
    private val output = mutableListOf<String>()

    init {
        nextActivations = grid.getCellsOfType(CellType.START)
            .map { Activation(Coordinate(-1000, -1000), it) }.toMutableList()

        // Fill it with some coordinate to indicate we are running.
        showAsActive = setOf(Coordinate(-1000, -1000))

        expectedOutput = grid.getOutput()
    }

    fun nextStep() {
        val newNextActivations = mutableListOf<Activation>()
        val currentStepOutput = mutableListOf<String>()
        val addToStopAfter = mutableSetOf<Coordinate>()

        showAsActive = nextActivations.map { it.current }.toSet()

        for (activation in nextActivations) {
            val currentCoordinate = Coordinate(activation.current.x, activation.current.y)
            val currentCell = grid.getCell(currentCoordinate)!!

            // Any action that comes back to start (and is not the first action) should just stop.
            if (currentCell.type == CellType.START && activation.from.x >= 0) {
                continue
            }

            if (currentCell.type.name.startsWith("OUTPUT")) {
                currentStepOutput.add(currentCell.type.name)

                // We stop execution after it landed on an output.
                continue
            }

            if (currentCell.type == CellType.STOP_AFTER_1) {
                if (stopAfter.contains(currentCoordinate)) {
                    continue
                }
                addToStopAfter.add(currentCoordinate)
            }

            newNextActivations.addAll(
                grid.getOrthogonalNeighbours(currentCoordinate)
                    .filter { it != activation.from }
                    .map { Activation(currentCoordinate, it) }
            )
        }

        nextActivations = newNextActivations
        stopAfter.addAll(addToStopAfter)

        console.log(currentStepOutput)

        if (currentStepOutput.isNotEmpty()) {
            output.add(currentStepOutput.joinToString("") { it.substringAfter('_') })
        }

        if (output == expectedOutput || isExpectedOutputIncorrect()) {
            // We are done.
            console.log("We are done!", output == expectedOutput, isExpectedOutputIncorrect())
            nextActivations = mutableListOf()
        }
    }

    private fun isExpectedOutputIncorrect(): Boolean {
        if (expectedOutput.size == 0) {
            return false
        }

        for (i in 0 until expectedOutput.size) {
            if (i >= output.size) {
                break
            }

            if (expectedOutput[i] != output[i]) {
                return true
            }
        }

        return false
    }

    fun getOutput(): List<String> {
        return output
    }

    fun isActive(coordinate: Coordinate): Boolean {
        return showAsActive.contains(coordinate)
    }

    fun isRunning(): Boolean {
        return showAsActive.isNotEmpty()
    }
}
