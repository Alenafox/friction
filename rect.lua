Rect = {}
Rect.__index = Rect

function Rect:create(location, color)
    local rect = {}
    setmetatable(rect, Rect)
    rect.location = location
    rect.color = color
    rect.size = 200
    return rect
end

function Rect:draw(color)
    local r,g,b,a = love.graphics.getColor()
    love.graphics.rectangle("fill", self.location.x, self.location.y, self.size, self.size * 2)
    if (color == 1) then
        love.graphics.setColor(0/255, 80/255, 20/255) 
    end
    if (color == 2) then
        love.graphics.setColor(130/255, 80/255, 20/255)
    end
end