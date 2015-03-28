# Separate the construction of a complex object from its representation so that
# the same construction process can create different representations
class BoardBuilder
  def initialize(width, height)
    @board = Board.new
    @board.width = width
    @board.height = height
    @board.tiles = []
    @board.monsters = []
  end

  def add_tiles(n)
    n.times{ @board.tiles << Tile.new }
  end

  def add_monsters(n)
    n.times{ @board.monsters << Monster.new }
  end

  def board
    @board
  end
end

class Board
  attr_accessor :width, :height, :tiles, :monsters
  def initialize
  end
end

class Tile; end
class Monster; end

# Usage
builder = BoardBuilder.new 2, 3
puts builder.board
# => Board Object
board = builder.board
puts board.width
# => 2
builder.add_tiles(3)
builder.add_monsters(2)
puts board.tiles.size
# => 3
puts board.monsters.size
# => 2