class Sprite

	def frames_loaded?
		@frames && @frames.length > 1
	end

	def step_animation
    if @tick > 10
      @tick = 0
      @current_frame += 1
    else
      @tick += 1
    end
    if @current_frame >= @current_animation.finish
      @current_animation.on_finished.call
      @current_frame = @current_animation.start 
    end
  end

  def load_tiles(path = "", opts = {})
    #Copied from Dare::Image, because callback was combining all loaded tiles into the same image
    image = Dare::Image.new(path)
    @tiles = []

    %x{
      #{image.img}.onload = function() {
        #{opts[:width] ||= image.width};
        #{opts[:height] ||= image.height};
        #{columns = image.width/opts[:width]};
        #{rows = image.height/opts[:height]};
        #{rows.times do |row|
          columns.times do |column|
            @tiles << Dare::ImageTile.new(image, column*opts[:width].to_i, row*opts[:height].to_i, opts[:width].to_i, opts[:height].to_i)
          end
        end};
      }
    }
    @tiles
  end
end