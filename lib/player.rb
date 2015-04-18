class Player
  attr_accessor :x, :y, :speed, :width, :height
  def initialize
    @x = @y = 0
    @img = Dare::Image.new('assets/player.png')
    @speed = 2
    @width = 32
    @height = 32
  end
  def draw(ctx)
    ctx.draw_rect(top_left: [x, y], width: 1, height: 1, color: 'blue')
    @img.draw(*G.mid)
  end
  def upper_level_bounds
    {
      x: width  + G.width  + (G.current_level.pixel_width  / 10), #need to capture these in a var
      y: height + G.height + (G.current_level.pixel_height / 8)
    }
  end
  def lower_level_bounds
    {
      x: -50 - width,
      y: -50 - height
    }
  end
  def update
    if x >= upper_level_bounds[:x] ||
       y >= upper_level_bounds[:y] ||
       x <= lower_level_bounds[:x] ||
       y <= lower_level_bounds[:y]
      puts 'ouch'
    end
  end
end