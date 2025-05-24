export function createGrid(cols, rows) {
  const grid = [];
  for (let y = 0; y < rows; y++) {
    const row = [];
    for (let x = 0; x < cols; x++) {
      row.push({
        x, y,
        alive: false,
        type: null
      });
    }
    grid.push(row);
  }
  return grid;
}

export function drawGrid(ctx, grid, cellSize) {
  for (let row of grid) {
    for (let cell of row) {
      const { x, y, alive, type } = cell;
      ctx.fillStyle = alive ? '#0f0' : '#333';
      if (type === 'seed') ctx.fillStyle = '#0ff';
      if (type === 'mutator') ctx.fillStyle = '#f0f';
      if (type === 'signal') ctx.fillStyle = '#ff0';

      ctx.fillRect(x * cellSize, y * cellSize, cellSize - 1, cellSize - 1);
    }
  }
}