PlayState = Class {__includes = BaseState}

function PlayState:init() end
function PlayState:enter() tetrominoes = Tetrominoes(0, 0) end

function PlayState:render()
    for i = 1, 16 do
        if (gBlocks[i]) then
            for j = 1, 11 do
                if (gBlocks[i][j]) then
                    gBlocks[i][j]:render()
                end
            end
        end
    end

    --TODO: Remove this when finished
    love.graphics.print("Score: " .. gPlayerScore, 0, 245)
end

function PlayState:update(dt)
    if (not gGamePaused) then
        tetrominoes:update(dt)

        if (tetrominoes._newTetromino._stopped) then
            for i = 16, 1, -1 do
                local count = 0
                for j = 1, 11 do
                    if (gBlocks[i][j]) then
                        count = count + 1
                    end
                end

                if (count == 10) then
                    gPlayerScore = gPlayerScore + 100
                    for j = 1, 11 do
                        gBlocks[i][j] = nil
                    end

                    for l = 15, 1, -1 do
                        for m = 1, 11 do
                            if (gBlocks[l][m]) then
                                gBlocks[l][m]:fall()
                                gBlocks[l][m]:updateInGBlocks()
                                gBlocks[l][m] = nil
                            end
                        end
                    end
                end
            end

            if (tetrominoes._newTetromino._y < 0) then
                gStateMachine:change("score")
            end
        end
    end

    if (love.keyboard.wasPressed("p")) then
        gGamePaused = not gGamePaused
    end
end

function PlayState:exit() end