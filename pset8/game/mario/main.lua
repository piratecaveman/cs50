-- Screen Setup
screen = {
    width = 1280,
    height = 720,
    virtual_width = 432,
    virtual_height = 243
}

-- Libraries
-- For documentation visit https://github.com/Ulydev/push
Push = require("lib/push")
Class = require("lib/class")

-- Classes for the Game
require("src/map")


function love.load()
    -- setting up random number system
    math.randomseed(os.time())
    -- Hold the value of the key last pressed
    love.keyboard.keys_pressed = {}
    -- get rid of blurriness in pixelated look
    love.graphics.setDefaultFilter('nearest', 'nearest', 0)
    -- setup virtual screen
    Push:setupScreen(
        screen.virtual_width,
        screen.virtual_height,
        screen.width,
        screen.height,
        {
            fullscreen = false,
            resizeable = true,
            vsync = true,
            pixelperfect = false,
            highdpi = true
        }
    )
    map = Map()
end

function love.keypressed(key)
    -- Update the key pressed
    love.keyboard.keys_pressed[key] = true
    
    -- Exit if escape is pressed
    if key == 'escape' then
        love.event.quit()
    end
end

function love.update(dt)
    -- update map
    map:update(dt)
    -- reset keys_pressed for each iteration
    love.keyboard.keys_pressed = {}
end

function love.draw()
    -- start painting
    Push:apply('start')

    -- flush the screen with the sky background color (rgb used) hex: #6b88fe
    love.graphics.clear(107/255, 136/255, 254/255, 255/255)
    map:render()

    -- render the map


    Push:apply('end')

end


-- custom functions
function love.keyboard.was_pressed(key)
    if (love.keyboard.keys_pressed[key]) then
        return true
    else
        return false
    end
end