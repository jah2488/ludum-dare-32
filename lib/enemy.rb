class Enemy < Sprite
	attr_accessor :x, :y, :dislike
	def initialize(x = 0, y = 0, dislike = 'dirt')
		@x = x; @y = y; @dislike = dislike; @height = 64
		@frames = load_tiles('assets/baddie.png', width: @height, height: @height)
		@walk = Animation.new(0,3)
		@current_frame = 0
		@current_animation = @walk
		@tick = 0
		@dir = 'fobar'
	end

  def draw(ctx)
	  if frames_loaded?
      @frames[@current_frame].draw(x, y)
      step_animation
	  end
	end

	def update(ctx)
		if @dir == 'left'
			if x > 0
				@x = @x - 1
			else
				if rand > 0.5
					@dir = 'right'
				else
					@dir = 'up'
				end			
			end
		end
		if @dir == 'right'
			if x < G.current_level.pixel_width - @height
				@x = @x + 1
			else
				if rand > 0.5
					@dir = 'up'
				else
					@dir = 'left'
				end
			end
		end
		if @dir == 'up'
			if @y > 0
				@y = @y - 1
			end
		end
		if @y < G.current_level.pixel_height - @height
			@y = @y + 1
		else
			unless ['up', 'left', 'right'].include?(@dir)
				if rand > 0.5
					@dir = 'left'
				else
					@dir = 'right'
				end
			end
		end
		# If near dislike item, move away
		# If near player, move towards
		# If touches player, hurt player (player bounces away)
		# If touches water, dies
	end
end