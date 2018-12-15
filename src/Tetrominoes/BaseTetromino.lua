---@class BaseTetromino
BaseTetromino = Class{}

local maxFallingTime = 0.5
local fallingTimer = maxFallingTime

------------Core functions---------------
function BaseTetromino:init(x, y, MAPPINGS)
    self._x, self._y = x, y
    self._blocks = {{}, {}, {}, {}} ---@type Block[][]
    self._mapping = {}
    self._mappingIndex = 1
    self._stopped = false

    self:useMapping(MAPPINGS)
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
    if (not self._stopped) then
        self:move()
        self:rotate()
        self:fall(dt)
        self:stop()
    end
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
    self._x = self._x - BLOCK_WIDTH
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                self._blocks[i][j]:moveLeft()
            end
        end
    end
end

function BaseTetromino:moveRight()
    self._x = self._x + BLOCK_WIDTH
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                self._blocks[i][j]:moveRight()
            end
        end
    end
end

function BaseTetromino:rotate(MAPPINGS)
    if (love.keyboard.wasPressed("space")) then
        if (self._mappingIndex < 4) then
            self._mappingIndex = self._mappingIndex + 1
        else
            self._mappingIndex = 1
        end
        self:useMapping(MAPPINGS)

        if (not self:checkBlocksPosValidity()) then
            if (self._mappingIndex == 1) then
                self._mappingIndex = 4
            else
                self._mappingIndex = self._mappingIndex - 1
            end
            self:useMapping(MAPPINGS)
        end
    end
end

function BaseTetromino:fall(dt)
    if (fallingTimer == 0) then
        self._y = self._y + BLOCK_HEIGHT
        for i = 1, 4 do
            for j = 1, 4 do
                if (self._blocks[i][j]) then
                    self._blocks[i][j]:fall()
                end
            end
        end
        fallingTimer = maxFallingTime
    else fallingTimer = math.max(0, fallingTimer - dt) end
end

function BaseTetromino:stop()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                if (self._blocks[i][j]._y >= 225) then
                    self._stopped = true
                    return
                end
            end
        end
    end
end

-----------------------------------------
function BaseTetromino:createBlockAt(row, column)
    local x, y = self._x + (column - 1) * BLOCK_WIDTH, self._y + (row - 1) * BLOCK_HEIGHT
    if (self._blocks[row] == nil) then
        self._blocks[row] = {}
    end
    self._blocks[row][column] = Block(x, y)
end

function BaseTetromino:useMapping(MAPPINGS)
    self._blocks = {{}, {}, {}, {}}
    self._mapping = MAPPINGS[self._mappingIndex]
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._mapping[i][j] == 1) then
                self:createBlockAt(i, j)
            end
        end
    end
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