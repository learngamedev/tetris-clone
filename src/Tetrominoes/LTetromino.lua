---@class LTetromino
LTetromino = Class{__includes = BaseTetromino}

local MAPPINGS = {
    {
        {1, 0, 0, 0},
        {1, 1, 1, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 1, 1, 0},
        {0, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0},
        {1, 1, 1, 0},
        {0, 0, 1, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 1, 0, 0},
        {0, 1, 0, 0},
        {1, 1, 0, 0},
        {0, 0, 0, 0}
    }
}

function LTetromino:init(x, y)
    BaseTetromino.init(self, x, y, MAPPINGS)
end

function LTetromino:rotate()
    BaseTetromino.rotate(self, MAPPINGS)
end