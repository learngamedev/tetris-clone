---@class ZTetromino : BaseTetromino
ZTetromino = Class{__includes = BaseTetromino}

local MAPPINGS = {
    {
        {0, 1, 1, 0},
        {1, 1, 0, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 1, 0, 0},
        {0, 1, 1, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0},
        {0, 1, 1, 0},
        {1, 1, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {1, 0, 0, 0},
        {1, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 0, 0}
    }
}

function ZTetromino:init(x, y)
    BaseTetromino.init(self, x, y, MAPPINGS)
end

function ZTetromino:rotate()
    BaseTetromino.rotate(self, MAPPINGS)
end