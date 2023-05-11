--json = require "Lib/json"
require "Lib/api"

if(lvl_now == nil) then
	lvl_now = 1
end

map = Map(lvl_now)

Tileset = love.graphics.newImage('Tileset.png')

Quads = {}

nbobj = 0 -- to win have to be 0
goal = {} -- cord where box have to be
nbal = 0 -- nb box already good

--cut image in quads
for i=0,56,8 do
    table.insert(Quads,love.graphics.newQuad(i,0,8,8,56,8))
end


print(Quads[tonumber(map.map[1])], map.map[31])

function drawMap()

    local x,y=8,8
    for i=1,(map.width*map.height) do
        
        if(map.map[i] ~= 0) then
			--draw the tiles
            love.graphics.draw(Tileset, Quads[tonumber(map.map[i])], x*8*2, y*8*2,0,2)
			--if you want to draw the numer of the tiles:

            --dat = tostring(map.map[i])
            --love.graphics.print(dat, x*8*2, y*8*2)
        end
        if(i%30 == 0) then--'jump' the print
            y=y+1
            x = 7
        end
        x=x+1
    end
end

function mapSet(x,y,s)--change the tiles location (x,y) to another (s)

	x = math.floor(x/16)
    y = math.floor(y/map.height)
    
    map.map[((y-1) * map.width + x)+1] = s
	s = tonumber(s)
end

function mapGet(x,y)--return the tiles code of a localition (x,y)
    x = math.floor(x/16)
    y = math.floor(y/map.height)
    
    return(tonumber(map.map[((y-1) * map.width + x)+1]))
end

function data()--load all the data of a map
	minx,miny = 128,96
	maxx,maxy = 30*16,17*16
	for x=minx,maxx,16 do
		for y=miny,maxy,16 do
			-- tile = box valid or goal
			if (mapGet(x,y) == 4 or mapGet(x,y) == 5) then
				tmp = {X=x,Y=y}
				table.insert(goal,tmp)
				--if box is valid
				if mapGet(x,y) == 5 then nbal = nbal + 1 end		
			end
			--if tile is player spawn
			--the x and y is pixel do i have to make sure it's 16*
			if mapGet(x,y) == 6 then
				mapSet(x,y,1)
				spawn.x,spawn.y = x+128,96+y
                print(x.." : "..y)
				p.x,p.y = x+128,96+y
			end
			-- if tile = box valid or not
			if (mapGet(x,y) == 3 or mapGet(x,y) == 4) then
				tmp = {X=x,Y=y}
				table.insert(box,tmp)
			end
		end
	end
	nbobj = #goal - nbal
	backup_nbobj = nbobj
end


--detect changment of a tile cord
function detect(x,y)
	if(x%16 == 0 and y%16 ==0) then
		if mapGet(x,y) == 3 then
			nbobj = nbobj - 1
			mapSet(x,y,4)
		elseif mapGet(x,y) ~=5 and mapGet(x,y)~=3 and mapGet(x,y)~=4 then
			mapSet(x,y,5)
			nbobj = nbobj + 1
		end
	end
end

function restart()--reset the map to the initial state
	--reset var
	nbobj=backup_nbobj+nbal
	moves = 0
	p.x,p.y = spawn.x,spawn.y
	
	minx,miny = 128,96
	maxx,maxy = 30*16,17*16
	--reset object on map
	for x=minx,maxx do
		for y=miny,maxy do
			if mapGet(x,y)==3 then
				mapSet(x,y,1)
			end
			if mapGet(x,y)==4 then
				mapSet(x,y,5)
			end
		end
	end
	
	-- reset box
	for i=1,#box do
		mapSet(box[i].X,box[i].Y,3)
	end
end