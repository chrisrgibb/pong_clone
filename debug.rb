class Debugmode

	def initialize(gosu)
		@gosu = gosu
		@font_size = 20
		@font = Gosu::Font.new(gosu, Gosu::default_font_name, @font_size)
		#@image = Gosu::Image.new(gosu, "media/paddle.png", false)
		@paddle1 = Paddle.new(gosu, 20, 120)
		@paddle2 = Paddle.new(gosu, 300, 120)
		@ball = Ball.new(gosu)
	end

	def update
		
		check_movements
		@ball.update
		@ball.check_collision(@paddle1)
		if @ball.off_screen_x? then
		  @ball.change_direction(0)
		end
	end

	def draw 
		@paddle1.draw
		@paddle2.draw
		@ball.draw
		font_draw
	end

	# draws debugging values 
	  # - coordinate of the ball
	def font_draw
		@font.draw( "Debug mode" , 49, 30 , 1, 1.0, 1.0, 0xfffff000 )
		@font.draw( ("x.pos: #{  @ball.xpos } y.pos %.0f" % [@ball.ypos]), 49, 50 , 1, 1.0, 1.0, 0xfffff000 )

	end

	def check_movements
	  if @gosu.button_down? Gosu::KbUp or @gosu.button_down? Gosu::GpButton0 then
         @paddle1.move_up
      end
      if @gosu.button_down? Gosu::KbDown or @gosu.button_down? Gosu::GpButton0 then
        @paddle1.move_down
      end
	end

	def button_down(id)
	  if id == Gosu::KbEnter || id == Gosu::KbReturn
			puts "down"
      	    @gosu.next_state(1)
      end
       # if id == Gosu::KbUp then
      #    @paddle1.move_up
      #  end 
      #  if id == Gosu::KbDown then
      #    @paddle1.move_down
      #   end
      case id
      when Gosu::Button::KbEscape
      @gosu.close
      end	
	end

	def button_up(id)
	  if id = Gosu::KbUp then
 		puts "button up"
	  end
	end

end


