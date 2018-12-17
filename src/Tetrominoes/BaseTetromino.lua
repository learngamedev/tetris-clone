---@class BaseTetromino
BaseTetromino = Class {}

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
        self:fallAccelerate()
        self:stop()
        if (self._stopped) then self:freeBlocks() end
    end
end
-----------------------------------------
function BaseTetromino:move()
    if (love.keyboard.wasPressed("left")) then
        self:moveLeft()
        if (not self:blocksInPlayArea()) or (not self:updateBlocksIndexes()) then
            self:moveRight()
        end
        self:updateBlocksIndexes()
    elseif (love.keyboard.wasPressed("right")) then
        self:moveRight()
        if (not self:blocksInPlayArea()) or (not self:updateBlocksIndexes()) then
            self:moveLeft()
        end
        self:updateBlocksIndexes()
    end
end

function BaseTetromino:moveLeft()
    self._x = self._x - BLOCK_WIDTH
    self:removeBlocksIndexes()
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
    self:removeBlocksIndexes()
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

        if (not self:blocksInPlayArea()) or (not self:updateBlocksIndexes()) then
            if (self._mappingIndex == 1) then
                self._mappingIndex = 4
            else
                self._mappingIndex = self._mappingIndex - 1
            end
            self:useMapping(MAPPINGS)
            self:updateBlocksIndexes()
        end
    end
end

function BaseTetromino:fall(dt)
    if (fallingTimer == 0) then
        self:removeBlocksIndexes()

        self._y = self._y + BLOCK_HEIGHT
        for i = 1, 4 do
            for j = 1, 4 do
                if (self._blocks[i][j]) then
                    self._blocks[i][j]:fall()
                end
            end
        end
        fallingTimer = maxFallingTime

        self:updateBlocksIndexes()
    else
        fallingTimer = math.max(0, fallingTimer - dt)
    end
end

function BaseTetromino:fallAccelerate()
    if (love.keyboard.wasPressed("down")) then
        maxFallingTime = 0.1
    end
    if (love.keyboard.wasReleased("down")) then
        maxFallingTime = 1.5
    end
end

function BaseTetromino:stop()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                local cur = self._blocks[i][j]
                local row, column = cur._y / BLOCK_HEIGHT + 1, cur._x / BLOCK_WIDTH + 1
                if (self._blocks[i][j]._y >= 225) then
                    self._stopped = true
                    return
                end

                if (gBlocks[row + 1]) then
                    if (gBlocks[row + 1][column]) then
                        if (i == 4) then
                            self._stopped = true
                            return
                        elseif (gBlocks[row + 1][column] ~= self._blocks[i + 1][j]) then
                            self._stopped = true
                            return
                        end
                    end
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
    self:removeBlocksIndexes()

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

function BaseTetromino:blocksInPlayArea()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                if (self._blocks[i][j]._x < 0) then
                    return false
                end
                if (self._blocks[i][j]._x >= WINDOW_WIDTH) then
                    return false
                end
            end
        end
    end
    return true
end

function BaseTetromino:removeBlocksIndexes()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                local cur = self._blocks[i][j]
                local row, column = cur._y / BLOCK_HEIGHT + 1, cur._x / BLOCK_WIDTH + 1
                if (gBlocks[row]) then
                    if (gBlocks[row][column] == cur) then
                        gBlocks[row][column] = nil
                    end
                end
            end
        end
    end
end

function BaseTetromino:updateBlocksIndexes()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                local cur = self._blocks[i][j]
                local row, column = cur._y / BLOCK_HEIGHT + 1, cur._x / BLOCK_WIDTH + 1
                if (gBlocks[row] == nil) then
                    gBlocks[row] = {}
                end
                if (gBlocks[row][column]) and (gBlocks[row][column] ~= cur) then
                    return false
                end
                gBlocks[row][column] = cur
            end
        end
    end
    return true
end

function BaseTetromino:freeBlocks()
    for i = 1, 4 do
        for j = 1, 4 do
            if (self._blocks[i][j]) then
                self._blocks[i][j] = nil
            end
        end
    end
end