require 'dare'
require_relative 'game'
require_relative 'camera'
require_relative 'utils/dir'
require_relative 'utils/animation'
require_relative 'utils/null'
require_relative 'sprite'
require_relative 'player'
require_relative 'level'
require_relative 'item'
require_relative 'enemy'

G = Game.new
Items = %w(dirt milk coin)

class Unweapon < Dare::Window

  def initialize
    super(width: G.width, height: G.height, border: true)
    @bg = Array.new(((G.width / G.tilesize) * (G.height / G.tilesize)) * 4) { Dare::Image.new('assets/bbwater.png') }
    # @bg = Dare::Image.new('assets/bg-big.png');
   
    @level  = Level.new(0, 0, 12, 10)
    @level.set_items Array.new(10) { Item.new(Items.sample) }
    @level.set_enemies(Enemy.new(@level.pixel_width / 2))

    @player = Player.new
    #So much camera setup. some abstraction is missing/wrong :[
    @camera = Camera.new(*G.mid)
    @camera.track(@player)

    G.set_level(@level)  
    G.set_player(@player)
    G.set_camera(@camera)
  end

  def draw
    # @bg.draw(G.camera.x - G.width, G.camera.y - G.height)
    @bg.each_slice((G.width / G.tilesize) * 2).with_index do |row, r_index|
      row.each_with_index do |tile, c_index|
        _x = c_index * G.tilesize
        _y = r_index * G.tilesize
        tile.draw(_x + G.camera.x - G.width, _y + G.camera.y - G.height)
      end
    end
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
# DONE Player should be able to pick up items found in the level
# DONE Animate Player
# DONE Enemy should exist on a level
# DONE Enemy should move on level
# Enemy should respond to Player holding item that enemy dislikes
# Enemy should avoid dislikes on level
