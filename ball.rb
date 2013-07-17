class Ball
	attr_accessor :angle, :xpos, :ypos, :xvel, :yvel

  def initialize(window)
  	@window =window
  	@image = Gosu::Image.new(window, "media/ball.png", false)
  	@xpos = 160
  	@ypos = 120
  	@xvel = -3
  	@yvel = Random.rand(0.5) * -3
  	@speed = 1
  	@angle = 0.0
  end

  def draw
  	@image.draw_rot(@xpos, @ypos, 5, 1)
  end

  def update
  	move_ball
  end

  def move_ball
  	@xpos = @xpos + @xvel
  	@ypos = @ypos + @yvel
  	if off_screen_y? then
  	  change_yvel
  	end
  end

  def check_collision(pad)
  	# figure out width of paddle.
  	@left = pad.x - pad.width
  	@right = pad.x + pad.width

  	@x = (xpos - pad.x).abs
  	@y = (ypos - pad.y)

  	if (@y >= -15 && @y <= 15 && @x <= 5)            
      change_direction(@y)     
    end 
    if (@x > 320)
      change_direction(@y)
    end
  end

  def off_screen_y?
    # 
  	if @ypos <= 0 or @ypos > @window.get_height then
       puts "off screen"
  	  return true
  	else
  	  return false
  	end
  end


  def off_screen_x?
    # 
    if @xpos <= 0 or @xpos > @window.get_width then
       puts "off screen"
      return true
    else
      return false
    end
  end

  def reset
    @xpos = 160
    @ypos = 120
    @yvel = 0
  end


  def change_yvel
  	@yvel = @yvel * -1
  end

  def get_x
    return @xpos
  end

  def get_y
    return @ypos
  end


  def change_direction(y)
     @xvel *= -1 # reverse direction
     @xpos = @xpos + (1 * @xvel)

    # find new angle of ball
    
    # up
    if y < -7.5 then
      @yvel += -2
    elsif y >= -7.5  && y <= 0  then
      @yvel += -1

    # down
    elsif y > 0 && y <= 7.5 then
      @yvel += 1
    else
     @yvel += 2
    end
  end  # end change_direction

end