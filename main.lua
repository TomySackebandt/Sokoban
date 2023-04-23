-- load some code

require "Screen/Game"
require "Screen/Menu"
require "Screen/Over"

font = love.graphics.newFont("BitPotionExt.ttf", 35)
love.graphics.setFont(font)

function love.load()
    Wwidth, Wheight = love.graphics.getDimensions()
    updateState = updateMenu
    drawState = drawMenu
end

function love.update()
    updateState()
end

function love.draw()
    drawState()
end


