BaseTetromino = Class {}

MAPPINGS = {
    {
        {1, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 0, 0}
    }
}

------------Core functions---------------
function BaseTetromino:init(x, y, MAPPINGS)
    self._x, self._y = x, y
    self._blocks = {{}, {}, {}, {}} ---@type Block[][]
    self._mapping = {}
    self._mappingIndex = 1
    self._stopped = false

    self:useMapping(MAPPINGS[1])
end

function BaseTetromino:render()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                self._blocks[i][j]:render()
            end
        end
    end
end

function BaseTetromino:update(dt)
    self:move()
end
-----------------------------------------
function BaseTetromino:move()
    if (love.keyboard.wasPressed("left")) then
        self:moveLeft()
        if (not self:checkBlocksPosValidity()) then
            self:moveRight()
        end
    elseif (love.keyboard.wasPressed("right")) then
        self:moveRight()
        if (not self:checkBlocksPosValidity()) then
            self:moveLeft()
        end
    end
end

function BaseTetromino:moveLeft()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                self._blocks[i][j]:moveLeft()
            end
        end
    end
end

function BaseTetromino:moveRight()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                self._blocks[i][j]:moveRight()
            end
        end
    end
end

function BaseTetromino:rotate()
end

function BaseTetromino:checkBlocksPosValidity()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                if (self._blocks[i][j]._x < 0) then return false end
                if (self._blocks[i][j]._x >= WINDOW_WIDTH) then return false end
            end
        end
    end
    return true
end
-----------------------------------------
function BaseTetromino:createBlockAt(row, column)
    local x, y = self._x + (column - 1) * BLOCK_WIDTH, self._y + (row - 1) * BLOCK_HEIGHT
    if (self._blocks[row] == nil) then
        self._blocks[row] = {}
    end
    self._blocks[row][column] = Block(x, y)
end

function BaseTetromino:useMapping(MAPPING)
    self._blocks = {{}, {}, {}, {}}
    self._mapping = MAPPING[self._mappingIndex]
    for i = 1, 4 do
        for j = 1, 4 do
            if (MAPPING[i][j] == 1) then
                self:createBlockAt(i, j)
            end
        end
    end
end
