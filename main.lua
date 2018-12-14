require("src/dependencies")

gGamePaused = false

function love.load()

end

function love.draw()
    --TODO: Remove this when finished
    love.graphics.print("RAM: "..math.floor(collectgarbage("count")).."KB", 0, 230)
end

function love.update(dt)
    require("lib/lovebird").update()
    
    if (not gGamePaused) then
    end

    if (love.keyboard.wasPressed("p")) then
        gGamePaused = not gGamePaused
    end

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end