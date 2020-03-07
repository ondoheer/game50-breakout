--[[
    GD50
    Breakout Remake

    -- PowerUp Class --

    Add a Powerup class to the game that spawns a powerup (images located at the bottom of the sprite sheet in the distribution code). This Powerup should spawn randomly, be it on a timer or when the Ball hits a Block enough times, and gradually descend toward the player. Once collided with the Paddle, two more Balls should spawn and behave identically to the original, including all collision and scoring points for the player. Once the player wins and proceeds to the VictoryState for their current level, the Balls should reset so that there is only one active again.

    
]]

PowerUp = Class{}

function PowerUp:init()

    self.width = 16
    self.height = 16
    self.x = VIRTUAL_WIDTH / 2 - 16
    self.y = VIRTUAL_HEIGHT / 5 - 16
    
    self.dx = 0
    self.dy = 0
    self.inPlay = false 
   

end

--[[
    It it hits the paddle then spawn 2 more balls
]]
function PowerUp:collides(target)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > target.x + target.width or target.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > target.y + target.height or target.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    return true
end

function PowerUp:hit()
  self.inPlay = false
  gSounds['select']:stop()
  gSounds['select']:play()
end

function PowerUp:update(dt)
    if self.inPlay then 
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt

        if self.y > VIRTUAL_HEIGHT then
            self.inPlay = false
            self.x =  VIRTUAL_WIDTH / 2 - 16
            self.y = VIRTUAL_HEIGHT / 5 - 16
        end
    end

end
function PowerUp:render()
    if self.inPlay then
        love.graphics.draw(gTextures['main'], gFrames['powerups'][7], self.x, self.y)
    end
end