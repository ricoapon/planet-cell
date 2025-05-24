export function updateSeed(oldGrid, newGrid, x, y) {
  const neighbors = getLiveNeighbors(oldGrid, x, y);

  if (oldGrid[y][x].alive) {
    newGrid[y][x].alive = neighbors === 2 || neighbors === 3;
  } else {
    newGrid[y][x].alive = neighbors === 3;
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