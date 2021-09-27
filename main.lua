require("vector")
require("mover")
require("rect")

function love.load() 
	width = love.graphics.getWidth()
	height = love.graphics.getHeight()
	love.graphics.setBackgroundColor(255 / 255, 255 / 255, 255 / 255)

	location_rect_one = Vector:create(width / 4 - 100, height / 6)
	location_rect_two = Vector:create(width /2 + 100, height / 6)
	location_first = Vector:create(width / 4, height/2)
	location_second = Vector:create(width - width/2 , height/2)
	velocity = Vector:create(0,0)
	mover = Mover:create(location_first, velocity)
	wmover = Mover:create(location_second, velocity)
	rect = Rect:create(location_rect_one, 1)
	wrect = Rect:create(location_rect_two, 2)

	wind = Vector:create(0.01, 0)
	isWind = false
	gravity = Vector:create(0, 0.01)
	isGravity = true
	floating = Vector:create(0, -0.02)
	isFloating = false

	width_rec = 200
	height_rec = 400
end

function love.update()
	mover:applyForce(gravity)
	wmover:applyForce(gravity)
	mover:applyForce(wind)
	wmover:applyForce(wind)

	if (mover.location.x > width / 4 - 100 and 
		mover.location.x < width / 4 - 100 + width_rec and
		mover.location.y > height / 6 and
		mover.location.y < height / 6 + height_rec) then
		friction = (mover.velocity * -1):norm()
		if friction then
			friction:mul(0.005)
			mover:applyForce(friction)
		end
	end
	if (wmover.location.x > width / 4 - 100 and 
		wmover.location.x < width / 4 - 100 + width_rec and
		wmover.location.y > height / 6 and
		wmover.location.y < height / 6 + height_rec) then
		friction = (mover.velocity * -1):norm()
		if friction then
			friction:mul(0.005)
			wmover:applyForce(friction)
		end
	end
	if (mover.location.x > width /2 + 100 and 
		mover.location.x < width /2 + 100 + width_rec and
		mover.location.y > height / 6 and
		mover.location.y < height / 6 + height_rec) then
		friction = (mover.velocity):norm()
		if friction then
			friction:mul(0.005)
			mover:applyForce(friction)
		end
	end
	if (wmover.location.x > width /2 + 100 and 
		wmover.location.x < width /2 + 100 + width_rec and
		wmover.location.y > height / 6 and
		wmover.location.y < height / 6 + height_rec) then
		friction = (wmover.velocity):norm()
		if friction then
			friction:mul(0.005)
			wmover:applyForce(friction)
		end
	end

	mover:update()
	mover:checkBoundaries()
	wmover:update()
	wmover:checkBoundaries()
end

function love.draw()
	love.graphics.setColor(130/255, 80/255, 20/255)
	wrect:draw(1)
	rect:draw(2)

	mover:draw()
	love.graphics.setColor(0, 0, 0)

	love.graphics.print(">0", wrect.location.x, rect.location.y)
	love.graphics.print("<0", rect.location.x, wrect.location.y)

	love.graphics.print(tostring(mover.velocity), mover.location.x + mover.size, mover.location.y)
	love.graphics.print("w: " .. tostring(isWind) .. "g: " .. tostring(isGravity) .. "f: " .. tostring(isFloating))
	
	wmover:draw()
	love.graphics.print(tostring(wmover.velocity), wmover.location.x + wmover.size, wmover.location.y)
	love.graphics.setColor(0, 0, 0)
	love.graphics.print("w: " .. tostring(isWind) .. "g: " .. tostring(isGravity) .. "f: " .. tostring(isFloating))
end