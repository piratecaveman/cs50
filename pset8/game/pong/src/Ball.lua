Ball = Class {}

function Ball:init(width, height, x, y)
    self.width = width
    self.height = height
    self.x = x - (self.width / 2)
    self.y = y - (self.height / 2)
    self.dx = math.random(-BALL_SPEED, BALL_SPEED)
    self.dy = math.random(-BALL_SPEED, BALL_SPEED)

    self.direction = nil
end

function Ball:reset()
    self.x = (VIRTUAL_WIDTH - self.width) / 2
    self.y = (VIRTUAL_HEIGHT - self.height) / 2
end

function Ball:render()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

function Ball:update(dt)
    self.x = self.x + (self.dx * dt)
    self.y = self.y + (self.dy * dt)
end

function Ball:deflect_horizontal()
    self.dx = -self.dx
end

function Ball:deflect_vertical()
    self.dy = -self.dy
end

function Ball:paddle_collision(paddle)
    if self.x > (paddle.x + paddle.width) then
        return false
    elseif self.y > (paddle.y + paddle.height) then
        return false
    elseif paddle.x > (self.x + self.width) then
        return false
    elseif paddle.y > (self.y + self.height) then
        return false
    else
        return true
    end
end

function Ball:edge_collision()
    if self.y < 1 then
        return "top"
    elseif (self.y > VIRTUAL_HEIGHT - self.height) then
        return "bottom"
    else
        return nil
    end
end

function Ball:boundary_touch()
    if self.x < 1 then
        return "left"
    elseif self.x > (VIRTUAL_WIDTH - self.width) then
        return "right"
    else
        return nil
    end
end

function Ball:get_direction()
    if self.dy > 0 then
        if self.dx > 0 then
            self.direction = "south_east"
        else
            self.direction = "south_west"
        end
    else
        if self.dx > 0 then
            self.direction = "north_east"
        else
            self.direction = "north_west"
        end
    end
end

function Ball:angle()
    if self.dx ~= 0 then
        factor = self.dy / self.dx
        factor = math.tan(factor)
        return factor
    else
        return "vertical"
    end
end
