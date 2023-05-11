function gprint(string,x,y)
    love.graphics.print(string,x,y)
end

function floor(int)
    return math.floor(int)
end

local t=0
function wait()
    t=t+1
    if t<2*60 then return end -- wait 2s
end