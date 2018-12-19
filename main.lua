require("src/dependencies")

gGamePaused = false
gPlayerScore = 0

function love.load()
    gStateMachine = StateMachine{
        ['play'] = function () return PlayState() end,
        ['score'] = function () return ScoreState() end
    }
    gStateMachine:change("play")
end

function love.draw()
    gStateMachine:render()
end

function love.update(dt)
    require("lib/lovebird").update()

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
end