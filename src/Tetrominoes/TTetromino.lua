---@class TTetromino : BaseTetromino
TTetromino = Class {__includes = BaseTetromino}

local MAPPINGS = {
    {
        {0, 1, 0, 0},
        {1, 1, 1, 0},
        {0, 0, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 1, 0, 0},
        {0, 1, 1, 0},
        {0, 1, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 0, 0, 0},
        {1, 1, 1, 0},
        {0, 1, 0, 0},
        {0, 0, 0, 0}
    },
    {
        {0, 1, 0, 0},
        {1, 1, 0, 0},
        {0, 1, 0, 0},
        {0, 0, 0, 0}
    }
}

function TTetromino:init(x, y)
    BaseTetromino.init(self, x, y, MAPPINGS)
end

function TTetromino:rotate()
    BaseTetromino.rotate(self, MAPPINGS)
end
