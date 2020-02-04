require_relative "tile"

class Board
  def self.generate_grid
    # testing grid filled with mines first
    Array.new(3) { Array.new(3) { Tile.new(true) } }
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
end