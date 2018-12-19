ScoreState = Class{__includes = BaseState}

function ScoreState:init() end
function ScoreState:render()
    love.graphics.print("Game Over!\nYour score: "..gPlayerScore, 30, 30)
end