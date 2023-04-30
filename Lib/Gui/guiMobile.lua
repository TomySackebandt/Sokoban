-- a lib for simple gui made by Enderto (me)

function guiUpdate()
    touches = love.touch.getTouches( )
end

Tablebutton = {}

function button(x,y,w,h,text,color,func)
    local newButton = {x=x,y=y,w=w,h=h,t=text,f=func}
    if color == 1 then
        newButton.cb = {0,0,0}
        newButton.ct = {1,1,1}
    end
    table.insert(Tablebutton,newButton)
    for i=0,#newButton do
        table.remove(newButton,i)
    end
end

local btnHold = false --variable to run just when btn is pressed
function click()
    for k,v in pairs(Tablebutton) do
        for key,va in pairs(touches) do
            local val = {}
            val.x,val.y =love.touch.getPosition( va )
            if(val.x > v.x and val.x < (v.x+v.w) and val.y > v.y and val.y < (v.y+v.h)) then
                v.cb = {1,1,1}
                v.ct = {0,0,0}
                if val.down and not btnHold then
                    v.f()
                    btnHold = true
                elseif not val.down then
                    btnHold = false
                end
            else
                v.cb = {0,0,0}
                v.ct = {1,1,1}
            end
        end
    end
end

function drawButton()
    for k,v in pairs(Tablebutton) do
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle("line",v.x,v.y,v.w,v.h)
        love.graphics.setColor(v.cb)
        love.graphics.rectangle("fill",v.x+2,v.y+2,v.w-4,v.h-4)
        love.graphics.setColor(v.ct)
        love.graphics.print(v.t,v.x+(v.w/4),v.y+(v.h/3))
    end
end
