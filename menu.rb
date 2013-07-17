class MainMenu 


	def initialize(gosu)
		@font_size = 40
		@gosu = gosu
		@image = Gosu::Image.new(gosu, "media/paddle.png", false)
		@font = Gosu::Font.new(gosu, Gosu::default_font_name, @font_size)
		@menu_items = [ "Play Game", "High Score", "Exit", "Debug Mode" ]
		@selected = 0
	end

	def draw
		#@image.draw_rot(100,100 , 5, 1) 
		for i in 0.. @menu_items.size
  	 	  if (i == @selected)	
       	    @font.draw( @menu_items[i]  , 49, 30+ ( @font_size* i), 1, 1.0, 1.0, 0xffffffff ) 
          else
      	    @font.draw( @menu_items[i]  , 49, 30+ ( @font_size* i), 1, 1.0, 1.0, 0xffff0000 ) 
        end
    end   
		#puts "drawing"
	end

	def update
	end

	def set_selected(value)
      @selected = value
    end

	def get_selected
	  return @selected
	end

	def move_selector_down
	  if @selected < @menu_items.size-1 then
	       @selected +=1
	   elsif @selected == @menu_items.length-1 then
	   	   @selected = 0
	  end
	end
	  

	def move_selector_up
	  if @selected > 0 then
	        @selected -= 1
	  elsif @selected == 0 then 
	  		@selected = @menu_items.length-1
	  end
	end

	def button_down(id)
		puts "bonus!!!"
		if id == Gosu::KbDown
			move_selector_down
		end
		if id == Gosu::KbUp
			move_selector_up
		end
		if id == Gosu::KbEscape
           @gosu.close
   		end
   		if id == Gosu::KbEnter || id == Gosu::KbReturn
   			@gosu.next_state(@selected)
        end
	end

	def change_state(state)
		#next_state
	end

end