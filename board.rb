require_relative "tile"

class Board
  def self.generate_board
    # testing board filled with mines first
    Array.new(3) { Array.new(3) { Tile.new(true) } }
  end

  def initialize
    @board = Board.generate_board
  end
end