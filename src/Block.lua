---@class Block
Block = Class{}

BLOCK_WIDTH, BLOCK_HEIGHT = 15, 15

function Block:init(x, y)
    self._x, self._y = x, y
end

function Block:render()
    love.graphics.rectangle("line", self._x, self._y, BLOCK_WIDTH, BLOCK_HEIGHT)
end

function Block:fall() self._y = self._y + BLOCK_HEIGHT end

function Block:moveLeft()
    self._x = self._x - BLOCK_WIDTH
    if (self._x < 0) then
        self:moveRight()
    end
end

function Block:moveRight()
    self._x = self._x + BLOCK_WIDTH
    if (self._x > WINDOW_WIDTH - BLOCK_WIDTH) then
        self:moveLeft()
    end
end