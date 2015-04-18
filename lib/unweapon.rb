require 'dare'
require_relative 'game'
require_relative 'camera'
require_relative 'player'
require_relative 'level'
require_relative 'item'

G = Game.new
Items = %w(dirt milk coin)

class Unweapon < Dare::Window

  def initialize
    super(width: G.width, height: G.height, border: true)
    @level  = Level.new
    @level.set_items Array.new(10) { Item.new(Items.sample) }

    G.set_level(@level)

    @player = Player.new
    G.set_player(@player)
    #So much camera setup. some abstraction is missing/wrong :[
    @camera = Camera.new(*G.mid)
    G.set_camera(@camera)
    @camera.track(@player)
    @camera.bounds = {
      x: [(@level.pixel_width  / 4) * -1, @level.pixel_width],
      y: [(@level.pixel_height / 4) * -1, @level.pixel_height]
    }
  end

  def draw
    @level.draw(self)
    @player.draw(self)
  end

  def update
    @player.update(self)
    @level.update(self)
    @camera.update(self)
  end

end

LD = Unweapon.new
LD.run!

# TODO
# DONE Create Player
# DONE Create Level
# DONE  - Level only needs a width and height of the island, location of exit, location of spawn, enemies, items
# DONE Player should be able to walk around level
# DONE Create Items
# DONE Items should be able to be placed on level
# Player should be able to pick up items found in the level
# Enemy should exist on a level
# Enemy should move on level
# Enemy should respond to Player holding item that enemy dislikes
