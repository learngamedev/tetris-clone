---@class Tetrominoes
Tetrominoes = Class{}

SHAPE_LIST = { "L", "O", "T", "I", "Z" }

function Tetrominoes:init()
    self._tetrominoes = {} ---@type BaseTetromino[][]
    self._newTetromino = nil
    self._spawnTetromino = true
end

function Tetrominoes:render()
    for i = 1, #self._tetrominoes do
        self._tetrominoes[i]:render()
    end
end

function Tetrominoes:update(dt)
    self:spawn(dt)

    for i = 1, #self._tetrominoes do
        self._tetrominoes[i]:update(dt)
    end
end

function Tetrominoes:add(x, y, shape, index)
    if (shape == "L") then self._newTetromino = LTetromino(x, y) end
    if (shape == "O") then self._newTetromino = OTetromino(x, y) end
    if (shape == "T") then self._newTetromino = TTetromino(x, y) end
    if (shape == "Z") then self._newTetromino = ZTetromino(x, y) end
    if (shape == "I") then self._newTetromino = ITetromino(x, y) end
    table.insert(self._tetrominoes, self._newTetromino)
end

function Tetrominoes:remove(atIndex)
    if (self._tetrominoes[atIndex]) then
        self._tetrominoes[atIndex] = nil
    end
end

function Tetrominoes:randomizeShape()
    local shapeIndex = math.random(1, #SHAPE_LIST)
    -- return SHAPE_LIST[shapeIndex]
    return "L"
end

function Tetrominoes:spawn(dt)
    -- Spawn new randomized Tetromino
    if (self._spawnTetromino) then
        self:add(4 * BLOCK_WIDTH, -(BLOCK_HEIGHT * 2), self:randomizeShape(), #self._tetrominoes + 1)
        self._spawnTetromino = false
    end

    if (self._newTetromino._stopped == true) then
        self._spawnTetromino = true
    end
end