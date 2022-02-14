wf = require 'windfield'

function love.load()
    cat = love.graphics.newImage("R.png")
    speedx, speedy = 0, 0
    world = wf.newWorld(0, 0, true)
    world:setGravity(0, 1024)
    world:addCollisionClass('Solid')
    box = world:newRectangleCollider(400 - 50/2, 0, cat:getDimensions())
    --box:setRestitution(0.8)
    --box:applyAngularImpulse(5000)

    ground = world:newRectangleCollider(0, 550, 800, 50)
    ground:setType('static')
    ground:setCollisionClass('Solid')

    wall_left = world:newRectangleCollider(0, 0, 50, 600)
    wall_left:setType('static')
    wall_left:setCollisionClass('Solid')

    wall_right = world:newRectangleCollider(750, 0, 50, 600)
    wall_right:setType('static')
    wall_right:setCollisionClass('Solid')
 
    jump = true
end

bool_to_number={ [true]=1, [false]=0 }

function love.update(dt)
    world:update(dt)
    VelocityX, VelocityY = box:getLinearVelocity()
    Answer = bool_to_number[love.keyboard.isDown('a')] - bool_to_number[love.keyboard.isDown('d')]

    speedx = speedx * 0.9
    speedx = speedx + Answer * -70

    box:setLinearVelocity(speedx, VelocityY)
end

function love.draw()
    world:draw() -- The world can be drawn for debugging purposes
    x, y = box:getPosition()
    w, h = cat:getDimensions()
    love.graphics.draw(cat, (x - w / 2), (y - h / 2))
    love.graphics.print("Speed X: " .. speedx, 60, 30)
    love.graphics.print("Speed Y: " .. speedy, 60, 50)
    love.graphics.print("Jump: " .. tostring(jump), 60, 70)
    love.graphics.print("Position: " .. box:getX() .. ", " .. box:getY(), 60, 100)
end