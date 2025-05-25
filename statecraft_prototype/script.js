const boardSize = 5;
const maxAlivePlacements = 3;
let alivePlacementsLeft = maxAlivePlacements;

const types = {
    EMPTY: 'empty',
    ALIVE: 'alive',
    TRIGGER: 'trigger',
    KILLER: 'killer',
    TOGGLE: 'toggle',
    LOCKED: 'locked'
};

let board = [
    [types.EMPTY, types.TRIGGER, types.EMPTY, types.KILLER, types.EMPTY],
    [types.EMPTY, types.EMPTY, types.TRIGGER, types.EMPTY, types.EMPTY],
    [types.TRIGGER, types.EMPTY, types.TOGGLE, types.EMPTY, types.KILLER],
    [types.EMPTY, types.EMPTY, types.TRIGGER, types.EMPTY, types.EMPTY],
    [types.EMPTY, types.KILLER, types.EMPTY, types.TRIGGER, types.EMPTY],
];

let states = Array.from({ length: boardSize }, () =>
    Array(boardSize).fill(false)
);

function renderBoard() {
    const boardDiv = document.getElementById("board");
    boardDiv.innerHTML = '';
    for (let y = 0; y < boardSize; y++) {
        for (let x = 0; x < boardSize; x++) {
            const btn = document.createElement("div");
            btn.className = `cell ${board[y][x]} ${states[y][x] ? 'alive' : ''}`;
            btn.textContent = states[y][x] ? '🟩' : '⬜';
            btn.onclick = () => handleClick(x, y);
            boardDiv.appendChild(btn);
        }
    }
}

function handleClick(x, y) {
    if (board[y][x] !== types.EMPTY) return;
    if (states[y][x]) {
        states[y][x] = false;
        alivePlacementsLeft++;
    } else if (alivePlacementsLeft > 0) {
        states[y][x] = true;
        alivePlacementsLeft--;
    }
    renderBoard();
}

function simulate() {
    const next = Array.from({ length: boardSize }, () =>
        Array(boardSize).fill(false)
    );

    function countAliveNeighbors(x, y) {
        let count = 0;
        for (let dx = -1; dx <= 1; dx++) {
            for (let dy = -1; dy <= 1; dy++) {
                if (dx === 0 && dy === 0) continue;
                const nx = x + dx, ny = y + dy;
                if (nx >= 0 && nx < boardSize && ny >= 0 && ny < boardSize) {
                    if (states[ny][nx]) count++;
                }
            }
        }
        return count;
    }

    for (let y = 0; y < boardSize; y++) {
        for (let x = 0; x < boardSize; x++) {
            const cellType = board[y][x];
            const alive = states[y][x];
            const neighbors = countAliveNeighbors(x, y);
            if (cellType === types.TOGGLE) {
                next[y][x] = !alive;
            } else if (cellType === types.TRIGGER) {
                next[y][x] = neighbors === 1;
            } else if (cellType === types.KILLER) {
                next[y][x] = neighbors < 2 ? alive : false;
            } else if (cellType === types.LOCKED) {
                next[y][x] = alive;
            } else {
                next[y][x] = alive;
            }
        }
    }

    states = next;
    renderBoard();
}

renderBoard();
