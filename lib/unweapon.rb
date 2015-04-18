require 'dare'
require_relative 'game'
require_relative 'camera'

class Player
  attr_reader :x, :y, :speed
  def initialize
    @x = @y = 0
    @img = Dare::Image.new('assets/player.png')
    @speed = 2.4
  end
  def draw(ctx)
    @img.draw(*G.mid)
  end
  def update
  end
end
class Level
  attr_reader :x, :y, :width, :height, :enemies, :items
  def initialize(x = 0, y = 0, width = 25, height = 20, enemies = [], items = [])
    @x = x; @y = y; @width = width; @height = height; @enemies = enemies; @items = items;
  end

  def draw(ctx)
    offset_x, offset_y = [x + G.camera.x - (pixel_width / 2), y + G.camera.y - (pixel_height / 2)]
    ctx.draw_rect(top_left: [offset_x, offset_y], width: pixel_width, height: pixel_height, color: 'goldenrod')
  end

  def pixel_width
    width * G.tilesize
  end

  def pixel_height
    height * G.tilesize
  end
end
G = Game.new
class Unweapon < Dare::Window

  def initialize
    super width: G.width, height: G.height, border: true
    @level  = Level.new
    @player = Player.new
    @camera = Camera.new(*G.mid)
    G.set_camera(@camera)
    @camera.track(@player)
  end

  def draw
    @level.draw(self)
    @player.draw(self)
    @camera.draw(self)
  end

  def update
    @player.update
    @camera.update(self)
  end

end

Unweapon.new.run!

# TODO
# Create Player
# Create Level
#   - Level only needs a width and height of the island, location of exit, location of spawn, enemies, items
# Player should be able to walk around level
# Player should be able to pick up items found in the level
# Enemy should exist on a level
# Enemy should move on level
# Enemy should respond to Player holding item that enemy dislikes
