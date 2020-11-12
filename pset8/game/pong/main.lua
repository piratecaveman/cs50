-- Requirements
Class = require("lib.class")
Push = require("lib.push")
MiddleClass = require("lib.middleclass")

require("src.Paddle")
require("src.Ball")
require("src.Computer")

-- Constants

-- -- Screen Parameters
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
WIDTH = 1280
HEIGHT = 720


-- -- Game Parameters
BALL_SPEED = 100
PADDLE_SPEED = 400
DIFFICULTY = 1
VICTORY_POINT = 10


-- Loading Assets
function love.load()
    
    -- seeding the monster
    math.randomseed(os.time())

    -- retro look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- fonts
    fonts = {
        title = love.graphics.setNewFont('assets/fonts/november.ttf', 10),
        score = love.graphics.setNewFont('assets/fonts/november.ttf', 32),
        victory = love.graphics.setNewFont('assets/fonts/november.ttf', 36)
    }

    -- sounds
    sounds = {
        background = love.audio.newSource('assets/music/background.wav', 'stream'),
        edge_hit = love.audio.newSource('assets/music/hit.wav', 'stream'),
        score = love.audio.newSource('assets/music/score.wav', 'stream'),
        paddle_hit = love.audio.newSource('assets/music/blip.wav', 'stream')
    }

    -- screen
    Push:setupScreen(
        VIRTUAL_WIDTH,
        VIRTUAL_HEIGHT,
        WIDTH,
        HEIGHT,
        {
            fullscreen = false,
            vsync = true,
            resizeable = false
        }
    )

    -- title
    love.window.setTitle("Pong Gyong")

    -- game variables
    scores = {
        player_one = 0,
        computer = 0,
        player_two = 0
    }

    game_state = {
        current = nil,
        previous = nil,
        possible = {
            "start",
            "play",
            "serve",
            "victory"
        }
    }
    -- Creating Objects
    player_one = Paddle(5, 20, 15, (VIRTUAL_HEIGHT - 20) / 2)
    player_two = Paddle(5, 20, VIRTUAL_WIDTH - 15, (VIRTUAL_HEIGHT - 20) / 2)
    computer = Computer(5, 20, VIRTUAL_WIDTH - 15, (VIRTUAL_HEIGHT - 20) / 2)
    ball = Ball(6, 6, VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2)
    
    -- Determine who serves
    serving_player = 'player_one'
    ball.dx = math.random(100, BALL_SPEED)


    -- Initial game state
    Winner = 0
    game_state.current = 'start'

    -- Music
    sounds.background:setLooping(true)
    sounds.background:play()

end

function change_state(state)
    game_state.previous = game_state.current
    game_state.current = state
end

function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "enter" or key == "return" then
        if game_state.current == 'start' then
            change_state('play')
        elseif game_state.current == 'serve' then
            change_state('play')
        elseif game_state.current == 'victory' then
            change_state('start')
        end
    end
end

function love.resize(width, height)
    Push:resize(width, height)
end

function love.update(dt)
    player_one:update(dt)
    computer:track_ball(ball.x, ball.y, ball.dx, ball.dy, dt)

    if ball:edge_collision() == "top" or ball:edge_collision() == "bottom" then
        sounds.edge_hit:play()
        ball:deflect_vertical()
    elseif ball:paddle_collision(player_one) == true or ball:paddle_collision(computer) == true then
        sounds.paddle_hit:play()
        ball:deflect_horizontal()
    end

    if love.keyboard.isDown('w') then
        player_one.dy = -PADDLE_SPEED
        player_one.direction = "up"
    elseif love.keyboard.isDown('s') then
        player_one.dy = PADDLE_SPEED
        player_one.direction ="down"
    else
        player_one.dy = 0
        player_one.direction = nil
    end

    if game_state.current == 'play' then
        ball:update(dt)

        if ball:boundary_touch() == "left" then
            sounds.score:play()
            scores.computer = scores.computer + 1
            ball:reset()
            if scores.computer >= VICTORY_POINT then
                change_state('victory')
                Winner = 'computer'
            else
                change_state('serve')
                serving_player = 'player_one'
                ball.dx = math.random(100, BALL_SPEED)
            end
        elseif ball:boundary_touch() == "right" then
            sounds.score:play()
            scores.player_one = scores.player_one + 1
            ball:reset()
            if scores.computer >= VICTORY_POINT then
                change_state('victory')
                Winner = 'player_one'
            else
                change_state('serve')
                serving_player = 'computer'
                ball.dx = -math.random(100, BALL_SPEED)
            end
        end
    end
end

function love.draw()
    Push:apply('start')
    love.graphics.clear(42 / 255, 45 / 255, 52 / 255, 255 / 255)

    love.graphics.setFont(fonts.score)
    love.graphics.print(scores.player_one, (VIRTUAL_WIDTH / 2) - 50, VIRTUAL_HEIGHT / 3)
    love.graphics.print(scores.computer, (VIRTUAL_WIDTH / 2) + 30, VIRTUAL_HEIGHT / 3)

    player_one:render()
    computer:render()
    love.graphics.setColor(1, 1, 0, 1)
    ball:render()
    love.graphics.setColor(0, 0, 0, 0)

    fps_counter()

    if game_state.current == "start" then
        love.graphics.setFont(fonts.title)
        love.graphics.printf("Welcome to Pong!", 0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.printf("Press Enter to start!", 0, 22, VIRTUAL_WIDTH, "center")
    elseif game_state.current == "serve" then
        love.graphics.setFont(fonts.title)
        if serving_player == 'player_one' then
            love.graphics.printf("Serving to Computer!", 0, 10, VIRTUAL_WIDTH, "center")
        elseif serving_player == "computer" then
            love.graphics.printf("Serving to Player 1!", 0, 10, VIRTUAL_WIDTH, "center")
        end
    elseif game_state.current == 'victory' then
        love.graphics.setColor(0, 1, 0, 1)
        love.graphics.setFont(fonts.score)
        love.graphics.printf("VICTORY!", 0, 10, VIRTUAL_WIDTH, "center")
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setFont(fonts.title)
        if Winner == "computer" then
            love.graphics.printf("Computer has won!", 0, 48, VIRTUAL_WIDTH, "center")
        elseif winner == "player_one" then
            love.graphics.printf("Player 1 has won!", 0, 48, VIRTUAL_WIDTH, 'center')
        end

        ball:reset()

        scores.player_one = 0
        scores.computer = 0
    end
    Push:apply('end')
end

function fps_counter()
    love.graphics.setColor(0, 1, 0, 1)
    local fps = tostring(love.timer.getFPS())
    love.graphics.setFont(fonts.title)
    love.graphics.print("FPS: " .. fps, 40, 20)
    love.graphics.setColor(1, 1, 1, 1)
end