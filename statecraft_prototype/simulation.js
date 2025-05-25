export function runSimulationStep(grid) {
  const newGrid = JSON.parse(JSON.stringify(grid));

  for (let y = 0; y < grid.length; y++) {
    for (let x = 0; x < grid[y].length; x++) {
      const cell = grid[y][x];

      updateForCell(grid, newGrid, x, y);
    }
  }

  return newGrid;
}

function updateForCell(oldGrid, newGrid, x, y) {
  const neighbors = getLiveNeighbors(oldGrid, x, y);
  const newCell = newGrid[y][x]
  if (neighbors === 2) {
    newCell.alive = true
  } else {
    newCell.alive = false
  }
}


function getLiveNeighbors(grid, x, y) {
  const dirs = [-1, 0, 1];
  let count = 0;

  for (let dy of dirs) {
    for (let dx of dirs) {
      if (dx === 0 && dy === 0) continue;
      const nx = x + dx, ny = y + dy;
      if (grid[ny] && grid[ny][nx] && grid[ny][nx].alive) {
        count++;
      }
    }
  }

  return count;
}
