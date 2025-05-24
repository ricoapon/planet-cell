import { updateSeed } from './types/seed.js';
import { updateMutator } from './types/mutator.js';

export function runSimulationStep(grid) {
  const newGrid = JSON.parse(JSON.stringify(grid));

  for (let y = 0; y < grid.length; y++) {
    for (let x = 0; x < grid[y].length; x++) {
      const cell = grid[y][x];

      switch (cell.type) {
        case 'seed':
          updateSeed(grid, newGrid, x, y);
          break;
        case 'mutator':
          updateMutator(grid, newGrid, x, y);
          break;
      }
    }
  }

  return newGrid;
}