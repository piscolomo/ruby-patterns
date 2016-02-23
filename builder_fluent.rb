# Variation of the Builder patter bringing in a fluent interface
# https://en.wikipedia.org/wiki/Fluent_interface
class Board
  attr_accessor :width, :height, :tiles, :monsters, :score

  def self.builder(width, height)
    Builder.new(width, height)
  end

  class Builder
    def initialize(width, height)
      @board = Board.new
      @board.width = width
      @board.height = height
      @board.tiles = []
      @board.monsters = []
    end

    def with_tiles(n)
      n.times{ @board.tiles << Tile.new }
      self
    end

    def with_monsters(n)
      n.times{ @board.monsters << Monster.new }
      self
    end

    def method_missing(meth, *args, &block)
      if meth.to_s =~ /with_(\w+)/
        property = $1
        if @board.respond_to?(property)
          @board.send("#{property}=",args[0])
        end
      else
        raise "There's no method called #{meth} here -- please try again."
      end
      self
    end

    def build
      @board
    end
  end

end

class Tile; end
class Monster; end

# Usage
board = Board::builder(2, 3).with_tiles(3).with_monsters(2).with_score(123).build
# => Board Object
board.width
# => 2
board.tiles.size
# => 3
board.monsters.size
# => 2
board.score
