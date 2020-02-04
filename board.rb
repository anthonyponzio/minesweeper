require_relative "tile"

class Board
  def self.generate_grid
    # Array.new(3) { Array.new(3) { Tile.new(true) } }

    # creating static board for testing
    board = [
      [Tile.new(board, true), Tile.new(board), Tile.new(board)],
      [Tile.new(board), Tile.new(board), Tile.new(board)],
      [Tile.new(board), Tile.new(board), Tile.new(board)],
    ]
    board
  end

  def initialize
    @grid = Board.generate_grid
  end

  def render
    @grid.each do |row|
      puts row.join(" ")
    end
    nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def reveal(pos)
    self[pos].reveal
  end

  def toggle_flag(pos)
    self[pos].toggle_flag
  end
end
