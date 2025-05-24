export function updateMutator(oldGrid, newGrid, x, y) {
  const neighbors = getLiveNeighbors(oldGrid, x, y);
  if (neighbors === 2) {
    newGrid[y][x].alive = !oldGrid[y][x].alive;
    if (newGrid[y][x + 1]) {
      newGrid[y][x + 1].alive = !oldGrid[y][x + 1].alive;
    }
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