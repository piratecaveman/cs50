function generate_quads(spritesheet, tile_width, tile_height)
    -- Quads table holds our quads
    local quads = {}
    -- Width of the spritesheet in terms of tiles
    local sheet_width = spritesheet:getWidth() / tile_width
    -- Height of the spritesheet in terms of tiles
    local sheet_height = spritesheet:getHeight() / tile_height
    -- Number corresponding to the current Tile
    local sheet_number = 1


    for y = 0, sheet_height - 1 do
        for x = 0, sheet_width - 1 do

            -- For documentation go here: https://love2d.org/wiki/love.graphics.newQuad
            local quad = love.graphics.newQuad(
                x * tile_width,
                y * tile_height,
                tile_width,
                tile_height,
                spritesheet:getWidth(),
                spritesheet:getHeight()
            )

            quads[sheet_number] = quad
            sheet_number = sheet_number + 1
        end
    end
    return quads
end
