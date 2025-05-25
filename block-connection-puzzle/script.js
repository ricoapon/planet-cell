const gridSize = 10;
const grid = document.getElementById("grid");
const output = document.getElementById("output");

let gridData = Array.from({ length: gridSize }, () =>
  Array.from({ length: gridSize }, () => ({ type: "empty" }))
);

// Pre-place blocks
gridData[2][2].type = "start";
gridData[2][3].type = "block";
gridData[2][4].type = "output";
gridData[3][4].type = "block";
gridData[4][4].type = "output";

gridData[3][2].type = "block";
gridData[4][2].type = "output";

function renderGrid() {
  grid.innerHTML = "";
  for (let y = 0; y < gridSize; y++) {
    for (let x = 0; x < gridSize; x++) {
      const cell = document.createElement("div");
      const cellData = gridData[y][x];
      cell.classList.add("cell");
      if (cellData.type !== "empty") cell.classList.add(cellData.type);
      if (isActive(x, y)) cell.classList.add("active");
      grid.appendChild(cell);
    }
  }
}

let pastActivatedBlocks = []
let activeBlocks = [[2, 2]]

function playAutomatically() {
  play()
  setTimeout(playAutomatically, 200)
}

function play() {
  let newActiveBlocks = []
  const text = document.createElement("p");

  for (let block of activeBlocks) {
    const type = gridData[block[0]][block[1]].type
    if (type === "output") {
      text.innerText += "yellow"
    }

    if (!isAlreadyActivated(block)) {
      pastActivatedBlocks.push(block)
    }

    // Find neighbours of the block and see which one we can trigger next.
    for (let neighbour of getNonEmptyOrthogonalNeighbours(gridData, block[1], block[0])) {
      if (!isAlreadyActivated(neighbour)) {
        newActiveBlocks.push(neighbour)
      }
    }
  }
  if (text.innerHTML !== "") {
    output.appendChild(text)
  }

  activeBlocks = newActiveBlocks
  renderGrid()
}

function isAlreadyActivated(block) {
  for (let alreadyActivatedBlock of pastActivatedBlocks) {
    if (alreadyActivatedBlock[0] === block[0] && alreadyActivatedBlock[1] === block[1]) {
      return true
    }
  }
  return false
}

function isActive(x, y) {
  for (let activeBlock of activeBlocks) {
    if (activeBlock[0] === y && activeBlock[1] === x) {
      return true
    }
  }
  return false
}

function getNonEmptyOrthogonalNeighbours(grid, x, y) {
  const dirs = [-1, 0, 1];
  let neighbours = []

  for (let dy of dirs) {
    for (let dx of dirs) {
      if (dx === 0 && dy === 0) continue;
      if (dx !== 0 && dy !== 0) continue;
      const nx = x + dx, ny = y + dy;
      if (grid[ny] && grid[ny][nx] && grid[ny][nx].type !== "empty") {
        neighbours.push([ny, nx]);
      }
    }
  }

  return neighbours;
}


renderGrid();
