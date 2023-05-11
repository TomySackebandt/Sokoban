-- Screen for the main menu / start menu
local btnLoad = false

LoadText = "Loading"


function updateLoading()

    guiUpdate()
    click()
    if not btnLoad then
        buttonReset()
        button(250,200,100,50,"Next",1,pass)
        btnLoad = true
    end

end

function message(message)
    LoadText = message
end

function pass()
    updateState = updateGame
    drawState = drawGame
end

function drawLoading()
    love.graphics.setColor(1,1,1)
    love.graphics.print(LoadText,Wwidth/2-100,Wheight/2-200,0,1)
    drawButton()
end