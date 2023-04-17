-- Screen for the main menu / start menu
function updateMenu()
    if love.keyboard.isDown( "z" ) then
        updateState = updateGame
        drawState = drawGame
     end
end

function drawMenu()
    love.graphics.print("Test Game",Wwidth/2-100,Wheight/2-100,0,2)
    love.graphics.print("Press Z to play",Wwidth/2-100,Wheight/2)
end