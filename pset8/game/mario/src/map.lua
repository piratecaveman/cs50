Map = Class {}

-- Quad generation functions
require("src/utils")
require("src/player")
require("src/animation")

-- quad_map
quads = {
    empty = 4,
    brick = 1,
    cloud_left = 6,
    cloud_right = 7,
    jump_box = 5,
    jump_box_hit = 9,
    bush_left = 2,
    bush_right = 3,
    pipe_top = 10,
    pipe_bottom = 11,
    flag_1 = 13,
    flag_2 = 14,
    flag_3 = 15,
    pole_top = 8,
    pole_mid = 12,
    pole_bottom = 16
}


function Map:init()
    self.spritesheet = love.graphics.newImage('assets/graphics/sprite-sheet.png')
    self.tile_width = 16
    self.tile_height = 16

    -- Area of the map
    self.width = 30
    self.height = 28

    -- map dimentions in pixels
    self.width_pixels = self.width * self.tile_width
    self.height_pixels = self.height * self.tile_height

    -- a map of tiles on the screen
    self.tiles = {}

    -- camera positions
    self.cam_x = 0
    self.cam_y = 0

    -- ground level
    self.ground = self.height / 2

    -- graphics
    self.sprites = generate_quads(self.spritesheet, self.tile_width, self.tile_height)

    -- filling the map with empty tiles
    for y = 1, self.height do
        for x = 1, self.width do
            self:set_tile(x, y, quads.empty)
        end
    end

    self.flag_animation = Animation({
        texture = self.texture,
        frames = {
            self.sprites[quads.flag_1], self.sprites[quads.flag_2], self.sprites[quads.flag_3]
        },
        interval = 0.25
    })

    self:procedural_generate()
    self:generate_pyramid()
    self:generate_pole()
    self:generate_flag()

    -- player object
    self.player = Player(self)

    sounds.background:setLooping(true)
    sounds.background:setVolume(0.40)
    sounds.background:play()
end


function Map:set_tile(x, y, tile)
    -- left to right, one step down, repeat
    self.tiles[(y - 1) * self.width + x] = {
        pos_x = x * self.tile_width,
        pos_y = y * self.tile_height,
        id = tile
    }

end

function Map:get_tile(x, y)
    return self.tiles[(y - 1) * self.width + x]
end

function Map:tile_at_pixel(x, y)
    local tile_x = math.floor(x / self.tile_width) + 1
    local tile_y = math.floor(y / self.tile_height) + 1
    return self:get_tile(tile_x, tile_y)
end 

function Map:update(dt)
    self.player:update(dt)

    -- camera movement
    local righter_most = math.min(self.player.x, self.width_pixels - screen.virtual_width)
    local lefter_most = math.min(self.player.x - screen.virtual_width / 2, righter_most)
    self.cam_x = math.max(0, lefter_most)

    self.flag_animation:update(dt)
end


function Map:render()
    for y = 1, self.height - 1 do
        for x = 1, self.width - 1 do
            -- love.graphics.draw(texture, quad, x, y, ...)
            -- draws pixels and they are zero indexed hence (x - 1) and (y - 1)
            love.graphics.draw(
                self.spritesheet, 
                self.sprites[self:get_tile(x, y).id],
                (x - 1) * self.tile_width,
                (y - 1) * self.tile_height
            )
        end
    end
    self.player:render()
end


function Map:procedural_generate()
    -- column by column
    local x = 1
    while x < self.width do

        -- clouds
        if x < self.width - 2 then
            if math.random(14) == 1 then
                local cloud_height = math.random(self.ground - 6)
                self:set_tile(x, cloud_height, quads.cloud_left)
                self:set_tile(x + 1, cloud_height, quads.cloud_right)
            end
        end

        if math.random(10) == 1 then
            if x < self.width - 2 then
                self:set_tile(x, self.ground - 1, quads.bush_left)
                for y = self.ground, self.height do
                    self:set_tile(x, y, quads.brick)
                end
                x = x + 1

                self:set_tile(x, self.ground - 1, quads.bush_right)
                for y = self.ground, self.height do
                    self:set_tile(x, y, quads.brick)
                end
                x = x + 1
            else
                for y = self.ground, self.height do
                    self:set_tile(x, y, quads.brick)
                end
                x = x + 1
            end
        elseif math.random(15) == 1 then
            if 2 < x and x < self.width - 2 then
                self:set_tile(x, self.ground - 2, quads.pipe_top)
                self:set_tile(x, self.ground - 1, quads.pipe_bottom)
                for y = self.ground, self.height do
                    self:set_tile(x, y, quads.brick)
                end
                x = x + 1
            else
                for y = self.ground, self.height do
                    self:set_tile(x, y, quads.brick)
                end
                x = x + 1
            end
        elseif math.random(16) == 1 then
            if 2 < x and x < self.width - 2 then
                self:set_tile(x, self.ground - 4, quads.jump_box)
                for y = self.ground, self.height do
                    self:set_tile(x, y, quads.brick)
                end
                x = x + 1 
            end
        elseif math.random(10) ~= 1 then
            for y = self.ground, self.height do
                self:set_tile(x, y, quads.brick)
            end
            x = x + 1
        elseif math.random(5) == 1 then
            x = x + 2
        end
    end
end

function Map:collision(x, y)
    local solid = {
        quads.brick,
        quads.pipe_top,
        quads.pipe_bottom,
        quads.jump_box,
        quads.jump_box_hit,
        quads.pole_top,
        quads.pole_mid,
        quads.pole_bottom
    }

    for _, v in ipairs(solid) do
        if self:tile_at_pixel(x, y).id == v then
            return true
        end
    end
    return false
end

function Map:generate_pyramid()
    local size = 6
    local pos_x = self.width - size - 6
    local pos_y = self.ground
    local current_x = 0

    for y = 1, size do
        for x = y, size do
            self:set_tile(pos_x + x, pos_y - y, quads.brick)
        end
    end
end


function Map:generate_pole()
    local height = 8
    local pos_x = self.width - 2
    local pos_y = self.ground

    for y = 1, height do
        if y == 1 then
            self:set_tile(pos_x, pos_y - y, quads.pole_bottom)
        elseif y == height then
            self:set_tile(pos_x, pos_y - y, quads.pole_top)
        else
            self:set_tile(pos_x, pos_y - y, quads.pole_mid)
        end
    end
end


function Map:generate_flag()
    local pos_x = self.width - 1
    local pos_y = self.ground - 8
    self:set_tile(pos_x, pos_y, quads.flag_1)
end

