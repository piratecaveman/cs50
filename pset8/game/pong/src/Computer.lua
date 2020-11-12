Computer = MiddleClass('Computer', Paddle)

function Computer:track_ball(ball_x, ball_y, ball_dx, ball_dy, dt)
    self.dy = math.sqrt(PADDLE_SPEED^2 + DIFFICULTY^2)
    if ball.x > VIRTUAL_WIDTH / 2 then
        if ball_dx > 0 then
            if ball_y < self.y then
                self.y = math.max(0, self.y - (self.dy * dt))
            elseif ball_y > self.y then
                self.y = math.min(self.y + (self.dy * dt), VIRTUAL_HEIGHT - 20)
            end
        end
    end
end

function Computer:trace(ball, dt)
    self.dy = self.dy * dt
    if self.y >= ball.y then
	    self.y = math.min(0, self.y - math.abs(self.dy))
    elseif self.y < ball.y then
	    self.y = math.min(VIRTUAL_HEIGHT - (self.height / 2) , self.y - math.abs(self.dy))
    end
end
