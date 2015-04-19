class Item
  # include Debug
  attr_accessor :x, :y, :height, :width, :name, :held

  def initialize(name)
    @font   = Dare::Font.new()
    @height = @width = 32
    @img    = Dare::Image.new("assets/#{name.downcase}.png")
    @name   = name
  end

  def draw(ctx)
    # super(ctx)
    @img.draw(x, y)
    # @font.draw(name, x, y + height / 2) if near_player?(50)
  end

  def mid
    [
      x + width  / 2,
      y + height / 2
    ]
  end

  def update(ctx)
    if near_player?(40) && G.player.pickup
      G.player.set_item(self)
    end
  end

  def near_player?(radius = 50)
    ((x - radius)..(x + radius)).include?(G.mid_x) &&
    ((y - radius)..(y + radius)).include?(G.mid_y)
  end

  def held?
    @held
  end
end