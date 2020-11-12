Paddle = MiddleClass('Paddle')

function Paddle:initialize(width, height, x, y)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    self.dx = 0
    self.dy = 0

    self.direction = nil
end

function Paddle:update(dt)
    self.y = self.y + (self.dy * dt)
    if self.y < 0 then
        self.y = 0
    elseif self.y > (VIRTUAL_HEIGHT - self.height) then
        self.y = VIRTUAL_HEIGHT - self.height
    end
end

function Paddle:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

