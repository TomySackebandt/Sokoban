
require "../Lib/utils"
require "../Lib/map"

--player var
p={ --player
    x=16,
    y=16,
    vx=0,
    vy=0,
    mx=0,
    my=0
}


lvl_now = 1 --current level
lvl_max = #AllMap() -- how many level the game have

print(lvl_max)

moves = 0 --how many move to finish the level

loaded = false --if the level has been loaded

have_win = false --game loop var

solids={[2]=true,[3]=true,[4]=true} --solid tiles

vx,vy = 0,0 -- for the direction of the player

spawn = {} -- cord spawn player

backup_nbobj = 0 
box = {} --box cord

margex,margey = 128,96

map = Map(1)

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
    if(key == "x") then
        --add function
        restart()
    end
    
end

function solid(x,y)
    local result = mapGet(x,y)
    return solids[result]
end

function col(x,y,sens,c)
    --sens = orientation = north:1, east:2, south:3, west:4
    vx,vy = 0,0
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
    if ( mapGet((x+vx),(y+vy))==3 and c==0 ) or ( mapGet((x+vx),(y+vy))==4 and c==0 ) then
        if col(x+vx,y+vy,sens,1) then -- call colision of box
            mapSet((x+vx),(y+vy),1)--erased last pos
            mapSet((x+(vx*2)),(y+(vy*2)),3)--write futur pos
        end
    end
    
    -- if tile is a solid
    if solid(x+vx,y+vy) then
        return false
    else
        -- moves up to 1
        if c == 0 then moves = moves + 1 end
        return true
    end

    
end


function updateGame()
    
    vx,vy = 0,0
    p.mx,p.my = p.x-margex,p.y-margey
    -- if the level is not finsih 
	if not have_win then
        if not loaded then --if lvl not loaded
            --remove some var
            nbal= 0
            for i=0,#goal do
                table.remove(goal)
            end
            for i=0,#box do
                table.remove(box)
            end
            --load data of the level
            data()
            restart()
            loaded = true
        end
        --detection if box is in a goals
		for i,v in ipairs(goal) do
			detect(v.X,v.Y)
		end

        --game loop test
		if nbobj == 0 then
			have_win = true
		end
    else -- if level finished
		-- when game finish
		if lvl_now >= lvl_max and moves~=0 then -- if finish game
            
			--print info level & finsih message
            updateState = updateOver
            drawState = drawOver
            
		else
            message("level "..lvl_now.."\n\nFinished in : \n"..moves.." moves !")
			--print info level
			moves = 0
			have_win = false
            lvl_now = lvl_now+1 --change level
            map = Map(lvl_now)
			loaded = false

            
            updateState = updateLoading
            drawState = drawLoading

		end
    end
end

function debug()
    gprint("X:"..p.mx,10,10)
    gprint("Y:"..p.my,10,30)
    
    if(p.x >= 128 and p.x < 608 and p.y >= 128 and p.y <400) then
        gprint(test(p.mx,p.my),120,60)
        if(mapGet(p.mx,p.my) ~= nil) then
            gprint(mapGet(p.x-margex,p.y-margey),120,30)
        end
        if(solid(p.mx,p.my) ~= nil) then
            gprint("solid",128,18)
        end
        
    end
    gprint(nbobj,222,15)

end

function drawGame()
    drawMap()--print the map
    love.graphics.draw(Tileset, Quads[2], p.x, p.y,0,2)--print the player
    --love.graphics.draw(Tileset, Quads[1], 20,20,0,4)
    --debug()
    love.graphics.rectangle("line",128,128,30*16,17*16)--print the map limit
    gprint("Game Map",96,96) --some text

    gprint("Moves: "..moves,100,10)
    gprint("Box: "..nbobj,100,30)

    gprint(map.name,320,410)
end


