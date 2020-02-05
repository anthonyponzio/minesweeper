require_relative "tile"

class Board
  attr_reader :grid

  def initialize
    @grid = generate_grid
  end

  def generate_grid
    # Array.new(3) { Array.new(3) { Tile.new(true) } }
    grid = []
    # creating static board for testing
    3.times do
      grid << [Tile.new(grid, true), Tile.new(grid), Tile.new(grid)]
    end

    grid
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

board = Board.new
p board[[0,0]].pos # => [0,0]
p board[[0,0]].adjacent_positions # => [[0,1], [1,0], [1,1]]
