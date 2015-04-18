class Game
  attr_reader :width, :height, :tilesize, :current_level
  def initialize(width = 640, height = 480, tilesize = 32)
    @width = width; @height = height; @tilesize = tilesize
  end
  def current_level
    @current_level
  end
  def set_level(level)
    @current_level = level
  end
  def mid
    [mid_x, mid_y]
  end
  def mid_x
    width / 2
  end
  def mid_y
    height / 2
  end
  def clamp(var, lower, upper)
    return lower if var <= lower
    return upper if var >= upper
    return var
  end
  def bounds_clamp_x(var)
    clamp(var, 0, width)
  end
  def bounds_clamp_y(var)
    clamp(var, 0, height)
  end
  def camera
    @camera
  end
  def set_camera(cam)
    @camera = cam
  end
end
