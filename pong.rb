

require 'gosu'
require 'rubygems'
include Gosu

class GameWindow < Gosu::Window

  WIDTH = 320
  HEIGHT = 240

  def initialize
    super WIDTH, HEIGHT, false
    self.caption = "pong"
 
    # ball and paddles
    @ball = Ball.new(self)
    @paddle1 = Paddle.new(self, 20, 120)
    @paddle2 = Paddle.new(self, 300, 120)
    
    # fonts and line
    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @score_font = Gosu::Font.new(self, "media/arcade.ttf", 40)
    @line =  Gosu::Image.new(self, "media/line.png", false)
    
    # Players Scores
    @score1 = 0
    @score2 = 0

    @game_started = false
    @pause = false 
    @running = true
    @game_finished = false
  end

  def draw
    @paddle1.draw
    @paddle2.draw
    @ball.draw
 
    #draw dotted line
    for i in 0 .. HEIGHT
      if (i % 20 == 0) then
        @line.draw( WIDTH/2, i, 1 , 1.0, 1.0)
      end
    end
  
  
    if @game_finished
      @font.draw(" Game Finished!"  , 20, 20, 1, 1.0, 1.0, 0xffffff00 )    

    elsif @pause
       @font.draw(" Paused:  dist #{@paddle1.y - @ball.ypos }  "  , 20, 20, 1, 1.0, 1.0, 0xffffff00 )    
       @font.draw( "Yvel: #{@ball.yvel}, Ypos #{@ball.ypos} , ydist #{@paddle1.y - @ball.ypos } " , 20, 35, 1, 1.0, 1.0, 0xffffff00 )        
    else
      @score_font.draw(" #{ @score1 }" , (WIDTH/6), 20, 1, 1.0, 1.0, 0xffffffff  )
      @score_font.draw(" #{ @score2 }" , (WIDTH-(WIDTH/3)), 20, 1, 1.0, 1.0, 0xffffffff)
    end  

  end

  def update
    return if @pause or !@running  or @game_finished
     check_movements
     check_y_axis
     check_collision(@paddle1)     
     check_collision(@paddle2)
     @ball.move_ball
  end

  def restart
    @ball.xpos = 120
    @ball.ypos = 120
    #@ball.yvel = Random.rand(0.5)  * -2
    @ball.yvel = 0
  end

  def check_movements
    if button_down? Gosu::KbUp or button_down? Gosu::GpButton0 then
      @paddle2.move_up
    end
    if button_down? Gosu::KbDown or button_down? Gosu::GpButton0 then
      @paddle2.move_down
    end
    if button_down? Gosu::KbA then
      @paddle1.move_up
    end
    if button_down? Gosu::KbZ  then
      @paddle1.move_down
    end
  end

  def check_y_axis
    if @ball.ypos <= 0  || @ball.ypos > HEIGHT then
        @ball.yvel = @ball.yvel * -1
    end
  end 


  def button_down(id)
    @pause = !@pause if id == Gosu::Button::KbSpace 
    return if @pause

    case id
    when Gosu::Button::KbEscape
      close
    end
  end

  def check_collision(pad)
  
    # figure out widths etc for paddle

       @left = pad.x - pad.width
       @right = pad.x + pad.width

     # check for both sides
       @x = (@ball.xpos - pad.x).abs
       @y = (@ball.ypos - pad.y)

    # check for collision with paddle
    if (@y >= -15 && @y <= 15 && @x <= 5)            
      @ball.change_direction(@y)     
    end 
      
    if @ball.ypos <= 0  then
      @ball.setYVel
    end
    if @ball.ypos > HEIGHT- 10 then
       @ball.yvel = -@ball.yvel
       
    end

    # check ball is not off screen
    if @ball.xpos < 0
       @score2 += 1
       if (@score2 ===10) then
         game_over
       else
         restart
       end
    elsif  @ball.xpos > WIDTH then
      @ball.xvel *= -1
      @score1 += 1
      if (@score1 ===10) then
         game_over
       else
         restart
       end
    end
  end
  
  
  def game_over
    @game_finished=true
    @pause = true
  end

  

end # end of Window Class

class Paddle

  attr_accessor :speed, :x, :y, :width, :height

  def initialize(window, x, y)
    @image = Gosu::Image.new(window, "media/paddle.png", false)
    @speed = 4
    @x = x  #20
    @y = y #120   
    @width = 10
    @height = 30
  end
 

  def draw
    @image.draw_rot(@x, @y , 5, 1)  
  end

  def update
  end

  def move_up
    if @y >0 
      @y =@y -@speed
    end
  end

  def move_down
     if @y < 225
       @y =@y+@speed
     end
  end
end



class Ball
   attr_accessor :angle, :xpos, :ypos, :xvel, :yvel

  def initialize(window)
    @image = Gosu::Image.new(window, "media/ball.png", false)
    @xpos = 160 
    @ypos = 120
    @xvel = -3
    @yvel = Random.rand(0.5)  * -3
    @speed = 1
    @angle = 0.0
  end

  def move_ball
    @xpos = @xpos + @xvel
    @ypos = @ypos + @yvel
  end

  def draw
    @image.draw_rot(@xpos, @ypos, 5, 1)
  end

  def change_direction(y)
     @xvel *= -1 # reverse direction
     @xpos = @xpos + (1 * @xvel)

   
    if y < -7.5 then
      @yvel += -2

    elsif y >= -7.5  && y <= 0  then
      @yvel += -1

    elsif y > 0 && y <= 7.5 then
      @yvel += 1

    else
     @yvel += 2
    end
  end

  def setSpeed(s)
    @speed = s
  end

  def setYVel
    @yvel = @yvel * -1
  end

  def setXPos(x)
    @xpos = x
  end
end # end of Ball class

window = GameWindow.new
window.show
