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
    end
  end

  def draw(ctx)
    ctx.draw_rect(top_left: [offset_x, offset_y], width: pixel_width, height: pixel_height, color: '#7FCB39')
    items.each do |item|
      # if !item.held?
        old_x, old_y = item.x, item.y
        item.x = offset_x + item.x
        item.y = offset_y + item.y
        item.draw(ctx)
        item.x, item.y = old_x, old_y
      # else
        # item.draw(ctx)
      # end
    end
  end

  def update(ctx)
    items.each do |item|
      old_x, old_y = item.x, item.y
      item.x = offset_x + item.x
      item.y = offset_y + item.y
      item.update(ctx)
      item.x, item.y = old_x, old_y
    end
  end

  def offset_x
    x + G.camera.x - (pixel_width / 2)
  end

  def offset_y
    y + G.camera.y - (pixel_height / 2)
  end

  def offset
    [offset_x, offset_y]
  end

  def pixel_width
    width * G.tilesize
  end

  def pixel_height
    height * G.tilesize
  end

  def pixels
    [pixel_width, pixel_height]
  end

  def random_placement
    [
      Array(1...width).select(&:odd?).sample  * G.tilesize, #select->odd because step(n) is not implemented in Opal *sadface*
      Array(1...height).select(&:odd?).sample * G.tilesize
    ]
  end
end