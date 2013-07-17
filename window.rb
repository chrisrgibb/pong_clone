class Game < Gosu::Window

	attr_accessor :current_state

	STATE = { :main_menu => "MainMenu.new(self)",
			  :game_1player => "GameWindow.new(self)",
			  :debug_mode => "Debugmode.new(self)"
	}

	def initialize
		@height = 240
		@width = 320
		super(@width, @height, false)
		self.caption = "pong"
	#	@current_state = eval(STATE[:main_menu])
	    @current_state = MainMenu.new(self)
		puts(@current_state)
	end

	def update
		@current_state.update
	end

	def draw
		@current_state.draw
	end

	def button_down(id)
		@current_state.button_down(id)
	end

	def button_up(id)
		
	end

	def next_state(state)
		if state == 0
			@current_state = eval(STATE[:game_1player])
		end
		if state == 1
			puts "yall"
			@current_state = eval(STATE[:main_menu])
		end
		if state == 2
			puts "close"
			@gosu.close
		end
		if state == 3
		   puts "debug_mode"
		   @current_state = eval(STATE[:debug_mode])
		end
		
		#@current_state = eval(STATE[state])
	end

	def get_height
	  return @height
	end

	def get_width
	  return @width
	end



end