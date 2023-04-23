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
        --mapSet(2,2,1)
        -- print("hey")
        -- print(mapGet(p.x+4,p.y+4))
    end
end

function updateGame()

end

function debug()
    gprint("X:"..p.x,10,10)
    gprint("Y:"..p.y,10,30)
    
    
    local margex,margey = 128,96
    if(p.x >= 128 and p.x < 608 and p.y >= 128 and p.y <400) then
        gprint(test(p.x-margex,p.y-margey),120,60)
        if(mapGet(p.x-margex,p.y-margey) ~= nil) then
            gprint(mapGet(p.x-margex,p.y-margey),120,30)
        end
    end

    love.graphics.line(p.x+8,0,p.x+8,1000)
    love.graphics.line(0,p.y+8,1000,p.y+8)

end

function drawGame()
    drawMap()
    love.graphics.draw(Tileset, Quads[1], p.x, p.y,0,2)
    --love.graphics.draw(Tileset, Quads[1], 20,20,0,4)
    debug()
    love.graphics.rectangle("line",128,128,30*16,17*16)
    gprint("Game Map",96,96)
end
