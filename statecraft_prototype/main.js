import { createGrid, drawGrid } from './grid.js';
import { runSimulationStep } from './simulation.js';

const canvas = document.getElementById('gameCanvas');
const ctx = canvas.getContext('2d');

const cols = 4;
const rows = 4;
const cellSize = 150;

let grid = createGrid(cols, rows);

// Demo: place a Seed at (10,10)
// grid[10][10].type = 'seed';
grid[1][1].alive = true;
grid[1][2].alive = true;
// grid[2][2].alive = true;
// grid[3][3].alive = true;

function gameLoop() {
  ctx.clearRect(0, 0, canvas.width, canvas.height);
  drawGrid(ctx, grid, cellSize);
}

function simulate() {
  grid = runSimulationStep(grid);
  gameLoop();
}

gameLoop();

// TEMP: Run sim every 1s
setInterval(simulate, 1000);
