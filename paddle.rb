class Paddle

  attr_accessor :speed, :x, :y, :width, :height, :score
	
  def initialize(gosu, x, y)
  	@image = Gosu::Image.new(gosu, "media/paddle.png", false)
  	@speed = 4
  	@x = x
  	@y = y
  	@width = 10
  	@height = 30
    @score = 0
  end

  def draw
  	@image.draw_rot(@x,@y, 5,1)
  end

  def move_up
  	if @y >0 
      @y =@y -@speed
    end
  end

  def move_down 
    if @y < 225  #so doesn't go off screen
       @y =@y+@speed
    end
  end

  def add_to_score
    @score = @score + 1
  end

  def get_score
    @score
  end


end