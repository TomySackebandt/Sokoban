-- Screen for the main menu / start menu
local btnLoad = false
function updateMenu()
    guiUpdate()
    click()
    if not btnLoad then
        button(250,200,200,100,"Start",1,pass)
        btnLoad = true
    end

end

function pass()
    updateState = updateGame
    drawState = drawGame
end

function drawMenu()
    love.graphics.setColor(1,1,1)
    love.graphics.print("Test Game",Wwidth/2-100,Wheight/2-100,0,2)
    drawButton()
end