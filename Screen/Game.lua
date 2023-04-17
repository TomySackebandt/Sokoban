require "../Lib/map"
require "../Lib/utils"


--player var
p={ --player
    x=16,
    y=16,
    vx=0,
    vy=0,
    life=3
}

function love.keypressed( key, scancode, isrepeat )
    if(key == "right") then
        p.x = p.x+16
    elseif(key == "left") then
        p.x = p.x-16
    elseif(key == "up") then
        p.y = p.y-16
    elseif(key == "down") then
        p.y = p.y+16
    end

    if(key == "z") then
        mapSet(2,2,1)
        print("hey")
        print(mapGet(p.x+4,p.y+4))
    end
end

function updateGame()

end

function debug()
    gprint("X:"..p.x,10,10)
    gprint("Y:"..p.y,10,30)
    if(mapGet(p.x/8,p.y/8) ~= nil) then
        gprint(mapGet(p.x/8,p.y/8),120,10)
    end
    gprint(test(p.x+4),10,60)
    --gprint(mapGet(p.x+4,p.y+4),120,30)
end

function drawGame()
    drawMap()
    love.graphics.draw(Tileset, Quads[1], p.x, p.y,0,2)
    --love.graphics.draw(Tileset, Quads[1], 20,20,0,4)
    debug()
end
