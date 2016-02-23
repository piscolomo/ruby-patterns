# Being an reflective, dynamic language, ruby allows you to avoid the
# traditional builder pattern as you can set arbitrary properties.
class Board
  attr_accessor :width, :height, :tiles, :monsters

  def initialize(params = {})
    params.each { |key, value| send "#{key}=", value }
  end

end

class Tile; end
class Monster; end

# Usage
board = Board.new(width:2, height:3, tiles: [Tile.new] * 3, monsters: [Monster.new] * 2)
# => Board Object
board.width
# => 2
board.tiles.size
# => 3
board.monsters.size
