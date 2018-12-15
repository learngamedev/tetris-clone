---@class OTetromino : BaseTetromino
OTetromino = Class{__includes = BaseTetromino}

local MAPPINGS = {
    {
        {0, 1, 1, 0},
        {0, 1, 1, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    }
}

function OTetromino:init(x, y)
    BaseTetromino.init(self, x, y, MAPPINGS)
end

function OTetromino:rotate() end