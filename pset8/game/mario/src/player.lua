Player = Class {}

require("src/animation")

local motion = {
    player_speed = 120,
    jump_speed = 400,
    gravity = 20
}


function Player:init(map)
    self.map = map
    self.width = 16
    self.height = 20

    -- location
    self.x = self.map.tile_width * 5
    self.y = self.map.tile_height * (self.map.ground - 1) - self.height

    -- graphics
    self.spritesheet = love.graphics.newImage('assets/graphics/blue_alien.png')
    self.quads = generate_quads(self.spritesheet, self.width, self.height)

    -- motion
    self.dx = 0
    self.dy = 0

    self.animations = {
        ['idle'] = Animation({
            texture = self.texture,
            frames = {
                self.quads[1]
            },
            interval = 1
        }),

        ['walking'] = Animation({
            texture = self.texture,
            frames = {
                self.quads[9], self.quads[10], self.quads[11]
            },
            interval = 0.15
        }),

        ['jumping'] = Animation({
            texture = self.texture,
            frames = {
                self.quads[3]
            },
            interval = 1
        })
    }

    self.state = 'idle'
    self.direction = 'right'
    self.current_animation = self.animations['idle']

    self.behaviour = {
        ['idle'] = function(dt)
            if love.keyboard.was_pressed('space') then
                self.state = 'jumping'
                self.dy = -motion.jump_speed
                self.animations[self.state]:reset()
                self.current_animation = self.animations[self.state]
                sounds.jump:play()
                self:bottom_collision()
            elseif love.keyboard.isDown('a') then
                self.state = 'walking'
                self.direction = 'left'
                self.dx = -motion.player_speed
                self.animations[self.state]:reset()
                self.current_animation = self.animations[self.state]
                self:bottom_collision()
            elseif love.keyboard.isDown('d') then
                self.state = 'walking'
                self.direction = 'right'
                self.dx = motion.player_speed
                self.animations[self.state]:reset()
                self.current_animation = self.animations[self.state]
                self:bottom_collision()
            else
                self.dx = 0
                self:bottom_collision()
            end
        end,

        ['walking'] = function(dt)
            if love.keyboard.was_pressed('space') then
                self.state = 'jumping'
                self.dy = -motion.jump_speed
                self.animations[self.state]:reset()
                self.current_animation = self.animations[self.state]
                sounds.jump:play()
                self:bottom_collision()
            elseif love.keyboard.isDown('a') then
                self.state = 'walking'
                self.direction = 'left'
                self.dx = -motion.player_speed
                self:left_collision()
                self:bottom_collision()
            elseif love.keyboard.isDown('d') then
                self.state = 'walking'
                self.direction = 'right'
                self.dx = motion.player_speed
                self:right_collision()
                self:bottom_collision()
            else
                self.state = 'idle'
                self.dx = 0
                self.animations[self.state]:reset()
                self.current_animation = self.animations[self.state]
                self:bottom_collision()
            end
            
            self:bottom_collision()
        end,

        ['jumping'] = function(dt)
            self.dy = self.dy + motion.gravity
            self:bottom_collision()
            if love.keyboard.isDown('a') then
                self.direction = 'left'
                self.dx = -motion.player_speed
                self:left_collision()
                self:bottom_collision()
            elseif love.keyboard.isDown('d') then
                self.direction = 'right'
                self.dx = motion.player_speed
                self:right_collision()
                self:bottom_collision()
            else
                self.dx = 0
                self:bottom_collision()
            end
            self:top_collision()
        end
    }

end


function Player:top_collision()
    if  self.dy < 0 then
        if self.map:collision(self.x, self.y) or self.map:collision(self.x + self.width, self.y) then
            self.dy = 0

            local tile_
            if self.map:collision(self.x, self.y) then
                tile_ = self.map:tile_at_pixel(self.x, self.y)
            else
                tile_ = self.map:tile_at_pixel(self.x + self.width, self.y)
            end

            if tile_.id == quads.jump_box then
                self.map:set_tile(tile_.pos_x / self.map.tile_width, tile_.pos_y / self.map.tile_height, quads.jump_box_hit)
                sounds.coin:setVolume(0.5)
                sounds.coin:play()
            else
                sounds.hit:setVolume(5)
                sounds.hit:play()
            end

        end
    end
end

function Player:bottom_collision()
    if self.map:collision(self.x, self.y + self.height) or self.map:collision(self.x + self.width, self.y + self.height) then
        if self.state == 'jumping' and self.dy > 0 then
            self.state = 'idle'
            self.dy = 0
            self.y = self.map:tile_at_pixel(self.x, self.y + self.height).pos_y - self.height - self.map.tile_height
            self.animations[self.state]:reset()
            self.current_animation = self.animations[self.state]
        end
    else
        self.state = 'jumping'
        self.animations[self.state]:reset()
        self.current_animation = self.animations[self.state]
    end
end

function Player:left_collision()
    if self.dx < 0 then
        -- the - 1 is important otherwise it will keep colliding with the ground
        if self.map:collision(self.x, self.y) or self.map:collision(self.x, self.y + self.height - 1) then
            self.dx = 0
            self:bottom_collision()
            sounds.empty:play()
        end
    end
end

function Player:right_collision()
    if self.dx > 0 then
        -- the - 1 is important otherwise it will keep colliding with the ground
        if self.map:collision(self.x + self.width, self.y) or self.map:collision(self.x + self.width, self.y + self.height - 1) then
            self.dx = 0
            self.x = self.map:tile_at_pixel(self.x + self.width, self.y).pos_x - 2 * self.map.tile_width
            self:bottom_collision()
            sounds.empty:play()
        end
    end
end

function Player:update(dt)
    if self.y > 300 then
        sounds.background:stop()
        sounds.death:play()
        return
    end

    self.behaviour[self.state](dt)
    self.current_animation:update(dt)

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end

function Player:render()
    local scale_x
    if self.direction == 'left' then
        scale_x = -1
    elseif self.direction == 'right' then
        scale_x = 1
    end


    -- love.graphics.draw(spritesheet, quad, x, y, ...)
    love.graphics.draw(
        self.spritesheet,
        self.current_animation:get_current_frame(),
        -- position x
        math.floor(self.x + self.width / 2),
        -- position y
        math.floor(self.y + self.height / 2),
        -- rotation
        0,
        -- scale x
        scale_x,
        --scale_y
        1,
        -- offset x
        self.width / 2,
        -- offset y
        self.height / 2
    )

end