require "../Lib/map"
require "../Lib/utils"


--player var
p={ --player
    x=16,
    y=16,
    vx=0,
    vy=0,
    mx=0,
    my=0
}

nbobj = 0 -- to win have to be 0
goal = {} -- cord where box have to be
nbal = 0 -- nb box already good


lvl_now = 1 --current level
lvl_max = 8 -- how many level the game have

moves = 0 --how many move to finish the level

loaded = false --if the level has been loaded

have_win = false --game loop var

solids={[2]=true,[3]=true,[4]=true} --solid tiles

vx,vy = 0,0 -- for the direction of the player

spawn = {} -- cord spawn player

backup_nbobj = 0 
box = {} --box cord

margex,margey = 128,96

function love.keypressed( key, scancode, isrepeat )--player move
    if(key == "right") and col(p.mx,p.my,2,0) then
        p.x = p.x+16
    elseif(key == "left") and col(p.mx,p.my,4,0)then
        p.x = p.x-16
    elseif(key == "up") and col(p.mx,p.my,1,0)then
        p.y = p.y-16
    elseif(key == "down") and col(p.mx,p.my,3,0)then
        p.y = p.y+16
    end

    --restart the level
    if(key == "z") then
        --add function
    end
end

function solid(x,y)
    return solids[mapGet(x,y)]
end

function col(x,y,sens,c)
    --sens = orientation = north:1, east:2, south:3, west:4
    
    if sens == 1 then
        vx = 0
        vy = -16
    elseif sens == 2 then
        vx = 16
        vy = 0
    elseif sens == 3 then
        vx = 0
        vy = 16
    elseif sens == 4 then
        vx = -16
        vy = 0
    end
    -- if cor for player and push a box
    if mapGet(floor((x+vx)),(floor(y+vy)))==3 and c==0 or mapGet(floor((x+vx)),(floor(y+vy)))==4 and c==0 then
        if col(x+vx,y+vy,sens,1) then -- call colision of box
            mapSet((x+vx),(y+vy),1)--erased last pos
            mapSet((x+vx*2),(y+vy*2),3)--write futur pos
        end
    end
    
    -- if tile is a solid
    if solid(x+vx,y+vy) or solid(x+7+vx,y+vy) or solid(x+vx,y+7+vy) or solid(x+7+vx,y+7+vy) then
        return false
    else
        -- moves up to 1
        if c == 0 then moves = moves + 1 end
        return true
    end
end

function updateGame()
    --data()
    p.mx,p.my = p.x-margex,p.y-margey

    if not loaded then --if lvl not loaded
        --remove some var
        nbal= 0
        for i=0,#goal do
            table.remove(goal)
        end
        --load data of the level
        data()
        loaded = true
        --if spawn ~= {} then p.x,p.y = spawn.x,spawn.y end
    end

end

function debug()
    gprint("X:"..p.x,10,10)
    gprint("Y:"..p.y,10,30)
    
    if(p.x >= 128 and p.x < 608 and p.y >= 128 and p.y <400) then
        gprint(test(p.mx,p.my),120,60)
        if(mapGet(p.mx,p.my) ~= nil) then
            gprint(mapGet(p.x-margex,p.y-margey),120,30)
        end
        if(solid(p.mx,p.my) ~= nil) then
            gprint("solid(p.mx,p.my)",128,18)
        end
        
    end
    --gprint(spawn.x,222,15)

end

function drawGame()
    drawMap()
    love.graphics.draw(Tileset, Quads[2], p.x, p.y,0,2)
    --love.graphics.draw(Tileset, Quads[1], 20,20,0,4)
    debug()
    love.graphics.rectangle("line",128,128,30*16,17*16)
    gprint("Game Map",96,96)
end


