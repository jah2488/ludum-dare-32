class Camera
  attr_accessor :x, :y, :tracking, :bounds
  def initialize(x = 0, y = 0)
    @x = x; @y = y
    @bounds = {
      x: [0, G.width],
      y: [0, G.height]
    }
  end

  def bounds
    @bounds
  end

  def track(obj)
    @tracking = obj
  end

  def tracking
    @tracking || Struct.new(:x, :y, :speed).new(@x, @y, 1)
  end

  def draw(ctx)
    ctx.draw_rect(top_left: [tracking.x, tracking.y], width: 20, height: 20, color: 'black')
    ctx.draw_rect(top_left: [x, y], width: 20, height: 20, color: 'black')
  end

  def update(ctx)
    speed = tracking.speed
    @y -= speed if ctx.button_down? Dare::KbDown
    @x -= speed if ctx.button_down? Dare::KbRight
    @x += speed if ctx.button_down? Dare::KbLeft
    @y += speed if ctx.button_down? Dare::KbUp
    @x = G.clamp(@x, bounds[:x][0], bounds[:x][1])
    @y = G.clamp(@y, bounds[:y][0], bounds[:y][1])
  end
end


