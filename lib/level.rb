module Dare
  class Image
    def tile(x = 0, y = 0, opts = {})
      opts[:canvas] ||= @canvas
      ctx     = opts[:canvas].context

      pattern = `#{ctx}.createPattern(#{@img}, 'repeat')`
      `#{ctx}.fillStyle = #{pattern}`
      %x{
        #{ctx}.fillRect(
          #{x},
          #{y},
          #{opts[:width]},
          #{opts[:height]})
      }
    end
  end
end

class Level
  attr_reader :x, :y, :width, :height, :enemies, :items
  def initialize(x = 0, y = 0, width = 25, height = 20, enemies = [], items = [])
    @x = x; @y = y; @width = width; @height = height; @enemies = enemies; @items = items;
    set_item_placement
    @bg = Array.new(width * height) { Item.new('grass') }
    #biggest hack ever since tiling doesn't work
    @bg.each_slice(width).with_index do |tiles, row_index|
      tiles.each_with_index do |tile, col_index|
        tile.x = G.tilesize * col_index + 1
        tile.y = G.tilesize * row_index + 1
      end
    end
  end

  def set_enemies(enemies)
    @enemies = Array(enemies)
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
    # ctx.draw_rect(top_left: [offset_x, offset_y], width: pixel_width, height: pixel_height, color: '#7FCB39') # V1
    # @bg.tile(offset_x, offset_y, width: pixel_width, height: pixel_height);    #V2
    @bg.each do |item|
      old_x, old_y = item.x, item.y
      item.x = offset_x + item.x
      item.y = offset_y + item.y
      item.draw(ctx)
      item.x, item.y = old_x, old_y
    end    

    draw_square(ctx, top_left: offset, bottom_right: pixels, color: '#736434', width: 5)


    items.each do |item|
      old_x, old_y = item.x, item.y
      item.x = offset_x + item.x
      item.y = offset_y + item.y
      item.draw(ctx)
      item.x, item.y = old_x, old_y
    end

    enemies.each do |enemy|
      old_x, old_y = enemy.x, enemy.y
      enemy.x = offset_x + enemy.x
      enemy.y = offset_y + enemy.y
      enemy.draw(ctx)
      enemy.x, enemy.y = old_x, old_y
    end
  end

  def draw_square(ctx, opts = {})
    ctx.draw_rect(top_left: opts[:top_left], width: opts[:bottom_right][0], height: opts[:width], color: opts[:color])
    ctx.draw_rect(top_left: opts[:top_left], width: opts[:width], height: opts[:bottom_right][1], color: opts[:color])

    ctx.draw_rect(top_left: [opts[:top_left][0],  opts[:bottom_right][1]  + opts[:top_left][1]], 
                     width: opts[:bottom_right][0] + opts[:width], 
                    height: opts[:width], 
                     color: opts[:color])
    ctx.draw_rect(top_left: [opts[:top_left][0] + opts[:bottom_right][0],   opts[:top_left][1]], 
                     width: opts[:width], 
                    height: opts[:bottom_right][1] + opts[:width], 
                     color: opts[:color])

  end

  def update(ctx)
    items.each do |item|
      old_x, old_y = item.x, item.y
      item.x = offset_x + item.x
      item.y = offset_y + item.y
      item.update(ctx)
      item.x, item.y = old_x, old_y
    end
    enemies.each do |enemy|
      enemy.update(ctx)
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