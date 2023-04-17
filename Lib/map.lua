--json = require "Lib/json"
map = require "map/TestMap"
Tileset = love.graphics.newImage('tiles.png')

Quads = {}

--cut image in quads
for i=0,24,8 do
    table.insert(Quads,love.graphics.newQuad(i,0,8,8,32,8))
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
    map.layers[1].data[x+((y-1)*30)] = s
end

function test(px)
    return math.floor(px/map.layers[1].width)
end

function mapGet(x,y)
    x = math.floor(x/map.layers[1].width)
    y = math.floor(y/map.layers[1].height)
    
    return(map.layers[1].data[x+((y-1)*map.layers[1].width)])
end