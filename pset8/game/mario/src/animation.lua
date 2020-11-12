Animation = Class {}

function Animation:init(args)
    self.texture = args.texture
    self.frames = args.frames
    self.interval = args.interval or 0.05
    self.timer = 0
    self.current_frame = 1
end

function Animation:get_current_frame()
    return self.frames[self.current_frame]
end

function Animation:reset()
    self.timer = 0
    self.current_frame = 1
end

function Animation:update(dt)
    
    self.timer = self.timer + dt

    while self.timer > self.interval do
        self.timer = self.timer - self.interval
        self.current_frame = (self.current_frame + 1) % (#self.frames + 1)
        if self.current_frame == 0 then 
            self.current_frame = 1
        end
    end
end