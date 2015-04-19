class Camera
  attr_accessor :x, :y, :tracking, :bounds
  def initialize(x = 0, y = 0)
    @x = x; @y = y
    @bounds = {
      x: [0, G.width],
      y: [0, G.height]
    }
  end

  def track(obj)
    @tracking = obj
  end

  def update(ctx)
    speed = 1
    speed = tracking.speed if tracking
    tracking.moving = false

    if ctx.button_down?(Dare::KbDown)  || ctx.button_down?(Dare::KbS)
      @y -= speed
      tracking.on_move(DIR::DOWN)
      tracking.moving = true
    end

    if ctx.button_down?(Dare::KbRight) || ctx.button_down?(Dare::KbD)
      @x -= speed
      tracking.on_move(DIR::RIGHT)
      tracking.moving = true
    end

    if ctx.button_down?(Dare::KbLeft)  || ctx.button_down?(Dare::KbA)
      @x += speed
      tracking.on_move(DIR::LEFT)
      tracking.moving = true
    end

    if ctx.button_down?(Dare::KbUp)    || ctx.button_down?(Dare::KbW)
      @y += speed
      tracking.on_move(DIR::UP)
      tracking.moving = true
    end

    @x = G.clamp(@x, bounds[:x][0], bounds[:x][1])
    @y = G.clamp(@y, bounds[:y][0], bounds[:y][1])
  end
end


