--json = require "Lib/json"
map = require "map/map"
Tileset = love.graphics.newImage('Tileset.png')

Quads = {}

--cut image in quads
for i=0,56,8 do
    table.insert(Quads,love.graphics.newQuad(i,0,8,8,56,8))
end

function drawMap()

    local x,y=8,8
    for i=1,(map.layers[1].width*map.layers[1].height) do
        
        if(map.layers[1].data[i] ~= 0) then
            love.graphics.draw(Tileset, Quads[map.layers[1].data[i]], x*8*2, y*8*2,0,2)
            --dat = tostring(map.layers[1].data[i])
            --love.graphics.print(dat, x*8*2, y*8*2)
        end
        if(i%30 == 0) then
            y=y+1
            x = 7
        end
        x=x+1
    end
end

function mapSet(x,y,s)
    --x,y = x+(8*8),y+(8*8)
	x = math.floor(x/16)
    y = math.floor(y/map.layers[1].height)
    
    map.layers[1].data[((y-1) * map.layers[1].width + x)+1] = s

    --map.layers[1].data[x+((y-1)*30)] = s
end

function mapGet(x,y)
    x = math.floor(x/16)
    y = math.floor(y/map.layers[1].height)
    
    return(map.layers[1].data[((y-1) * map.layers[1].width + x)+1])
end


function test(x,y)

    --x = math.floor(x/map.layers[1].width*2)
    x = math.floor(x/16)
    y = math.floor(y/map.layers[1].height)
    
    --return(x+((y-1)*map.layers[1].width))
    return ((y-1) * map.layers[1].width + x) +1

end

function data()
	minx,miny = 128,96
	maxx,maxy = 30*16,17*16
	for x=minx,maxx do
		for y=miny,maxy do
			-- tile = box valid or goal
			if mapGet(x,y) ==4 or mapGet(x,y) == 5 then
				tmp = {X=x,Y=y}
				table.insert(goal,tmp)
				--if box is valid
				if mapGet(x,y) == 5 then nbal = nbal + 1 end		
			end
			--if tile is player spawn
			--the x and y is pixel do i have to make sure it's 16*
			if mapGet(x,y) == 6 and (x % 16 == 0) and  (y % 16 == 0)then
				mapSet(x,y,1)
				spawn.x,spawn.y = x+128,96+y
                print(x.." : "..y)
				p.x,p.y = x+128,96+y
			end
			-- if tile = box valid or not
			if mapGet(x,y) == 3 or mapGet(x,y) == 5 then
				tmp = {X=x,Y=y}
				table.insert(box,tmp)
			end
		end
	end
	nbobj = #goal - nbal
	backup_nbobj = nbobj
end
