class GameWindow

	def initialize(gosu)
		@gosu = gosu
		#@image = Gosu::Image.new(gosu, "media/paddle.png", false)
		@paddle1 = Paddle.new(gosu, 20, 120)
		@paddle2 = Paddle.new(gosu, 300, 120)
		@ball = Ball.new(gosu)
		@score_font = Gosu::Font.new(gosu, "media/arcade.ttf", 50)
		@line =  Gosu::Image.new(gosu, "media/line.png", false)
		@pause = false
		@color1 = Gosu::Color.new(100,255,255,150)
	end

	def update
		return if @pause
			check_movements
			@ball.update
			@ball.check_collision(@paddle1)
			@ball.check_collision(@paddle2)
			#if @ball.off_screen_y? then
			  
			#end
			if @ball.off_screen_x? then
			  @ball.change_direction(0)
			  do_scoring
			end
	end

	def draw
		@paddle1.draw
		@paddle2.draw
		@ball.draw
		draw_score
		draw_line
		if @pause == true then 
			@score_font.draw( " PAUSED ", 80, 100 ,100 ,1 ,1, 0xffffffff  )
			@gosu.draw_quad( 0, 0, @color1,
							 320 ,0, @color1 ,
							 0, 240, @color1, 
							 320, 240 ,@color1, 4 )
							# ,200,150,@color1 )
		end
	end

	# draws the score
	def draw_score
	  width = @gosu.get_width
	  @score_font.draw(" #{ @paddle1.score }" , (width/6), 20, 1, 1.0, 1.0, 0xffffffff  )
      @score_font.draw(" #{ @paddle2.score }" , (width-(width/3)), 20, 1, 1.0, 1.0, 0xffffffff)
    end

    def draw_line
      for i in 0 .. @gosu.get_height
        if (i % 20 == 0) then
          @line.draw( @gosu.get_width/2, i, 1 , 1.0, 1.0)
        end
      end
    end


    #checks for input and moves paddles accordingly
	def check_movements
	  if @gosu.button_down? Gosu::KbUp or @gosu.button_down? Gosu::GpButton0 then
         @paddle2.move_up
      end
      if @gosu.button_down? Gosu::KbDown or @gosu.button_down? Gosu::GpButton0 then
         @paddle2.move_down
      end
      if @gosu.button_down? Gosu::KbA then
         @paddle1.move_up
      end
      if @gosu.button_down? Gosu::KbZ  then
         @paddle1.move_down
      end
	end

	def button_down(id)
      #@pause = !@pause if id == Gosu::Button::KbP 
      
      if id == Gosu::Button::KbP then
        @pause = !@pause
      end    

	  if id == Gosu::KbEnter || id == Gosu::KbReturn
	  	# go back to menu
      	@gosu.next_state(1)
	  end

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

	def do_scoring
	  # first check if ball is off left side
	  if (@ball.xpos - 10) <= 0 then
	  	puts "ball < 0"
	  	@paddle1.add_to_score
	  	@ball.reset
	  end
      # now check if ball is off right side
	  if (@ball.xpos + 10) >= @gosu.get_width then
	  	puts "ball > width"
	  	@paddle2.add_to_score
	  	@ball.reset
	  end
	 
      if (@paddle1.get_score > 10 || @paddle2.get_score > 10 ) then
      	game_over
      end

    end

    def game_over
      @pause = !@pause

    end

end