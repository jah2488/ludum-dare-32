class Level
  attr_reader :x, :y, :width, :height, :enemies, :items
  def initialize(x = 0, y = 0, width = 25, height = 20, enemies = [], items = [])
    @x = x; @y = y; @width = width; @height = height; @enemies = enemies; @items = items;
    set_item_placement
  end

  def set_items(items)
    @items = Array(items)
    set_item_placement #This will cause all items to be reshuffled it the list is only being altered slightly
  end

  def set_item_placement
    items.each do |item|
      item.x, item.y = random_placement
      puts item, item.x, item.y
    end
  end

  def draw(ctx)
    offset_x, offset_y = [x + G.camera.x - (pixel_width / 2), y + G.camera.y - (pixel_height / 2)]
    ctx.draw_rect(top_left: [offset_x, offset_y], width: pixel_width, height: pixel_height, color: 'goldenrod')
    items.each do |item|
      old_x, old_y = item.x, item.y
      item.x = offset_x + item.x
      item.y = offset_y + item.y
      item.draw(ctx)
      item.x, item.y = old_x, old_y
    end
  end

  def pixel_width
    width * G.tilesize
  end

  def pixel_height
    height * G.tilesize
  end

  def random_placement
    [
      Array(1...width).sample  * G.tilesize,
      Array(1...height).sample * G.tilesize
    ]
  end
end