class Item
  attr_accessor :x, :y, :height, :width, :name

  def initialize(name)
    @font   = Dare::Font.new()
    @height = @width = 32
    @img    = Dare::Image.new("assets/#{name.downcase}.png")
    @name   = name
  end

  def draw(ctx)
    @img.draw(x, y)
    @font.draw(name, x, y + height / 2) if near_player?(50)
  end

  def near_player?(radius)
    (G.mid_x-radius..G.mid_x+radius).include?(x) &&
    (G.mid_y-radius..G.mid_y+radius).include?(y)
  end
end