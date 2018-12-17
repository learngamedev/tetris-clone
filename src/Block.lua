---@class Block
Block = Class {}

BLOCK_WIDTH, BLOCK_HEIGHT = 15, 15

gBlocks = {} ---@type Block[][]

function Block:init(x, y)
    self._x, self._y = x, y
end

function Block:render()
    love.graphics.rectangle("line", self._x, self._y, BLOCK_WIDTH, BLOCK_HEIGHT)
end

function Block:fall() self._y = self._y + BLOCK_HEIGHT end
function Block:moveLeft() self._x = self._x - BLOCK_WIDTH end
function Block:moveRight() self._x = self._x + BLOCK_WIDTH end

function Block:updateInGBlocks()
    local row, column = self._y / BLOCK_HEIGHT + 1, self._x / BLOCK_WIDTH + 1
    if (gBlocks[row] == nil) then
        gBlocks[row] = {}
    end
    gBlocks[row][column] = self
end