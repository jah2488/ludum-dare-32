class Null
  
  def to_s
    "I don't exist"
  end

  def ! 
    true
  end
  
  def nil?
    true
  end
  
  def falsey?
    true
  end
  
  def method_missing(name, *args, &block)
    self
  end

end
module DIR
  UP = 'UP'
  DOWN = 'DOWN'
  LEFT = 'LEFT'
  RIGHT = 'RIGHT'
end
class Animation < Struct.new(:start, :end);
end
class Player
  attr_accessor :x, :y, :speed, :width, :height, :item, :pickup, :moving
  def initialize
    @x = @y = 0
    @frames = Dare::Image.load_tiles('assets/anim_player.png', width: 32, height: 32)
    @right = Animation.new(12, 14)
    @left = Animation.new(15,17)
    @walk = Animation.new(0, 5)
    @back = Animation.new(6, 11)
    @facing = DIR::DOWN
    @current_animation = @walk
    @current_frame = 0
    @speed = 2
    @width = 32
    @height = 32
    @item = Null.new
    @tick = 0
  end
  
  def draw(ctx)
  
    if frames_loaded?
      @frames[@current_frame].draw(*G.mid)

      if moving?
        if @tick > 10
          @tick = 0
          @current_frame += 1
        else
          @tick += 1
        end
        @current_frame = @current_animation.start if @current_frame >= @current_animation.end
      end
    end

    ctx.draw_rect(top_left: G.mid, width: 2, height: 10, color: 'red') if @pickup
  end

  def frames_loaded?
    @frames && @frames.length > 1
  end
  
  def update(ctx)
    if coords[:x] >= upper_level_bounds[:x] ||
       coords[:y] >= upper_level_bounds[:y] ||
       coords[:x] <= lower_level_bounds[:x] ||
       coords[:y] <= lower_level_bounds[:y]
      puts 'ouch'
    end
    if ctx.button_down?(Dare::KbSpace) && @item.nil?
      @pickup = true
    else
      @pickup = false
    end
    if ctx.button_down?(Dare::KbShift)
      drop_item
    end

    @item.x, @item.y = coords[:x], coords[:y]
  end

  def moving?
    @moving
  end

  def on_move(dir)
    if @facing != dir
      @facing = dir
      case @facing
      when DIR::DOWN  then @current_animation = @walk
      when DIR::LEFT  then @current_animation = @left
      when DIR::RIGHT then @current_animation = @right
      when DIR::UP    then @current_animation = @back
      end
      @current_frame = @current_animation.start
    end
  end

  def set_item(item)
    @item = item
    @item.held = true
  end

  def drop_item
    @item.held = false
    @item = Null.new
  end

  #This is a failure of the camera system and should eventually be moved
  def upper_level_bounds
    {
      x: G.current_level.pixel_width - width / 2,
      y: G.current_level.pixel_height - height / 2
    }
  end
  
  def lower_level_bounds
    {
      x: -width / 2,
      y: -height / 2
    }
  end

  def coords
    {
      x: G.mid_x - G.current_level.offset_x,
      y: G.mid_y - G.current_level.offset_y
    }
  end

end