require_relative "tile"

class Board
  attr_reader :grid

  def initialize(grid_size)
    @grid = Array.new(grid_size) { Array.new(grid_size) }
    fill_grid(grid_size)
  end

  def fill_grid(mine_count)
    size = @grid.size
    grid_indices = (0...size)
    mine_bag = []

    (size * size).times do
      if mine_count > 0
        mine_bag << true
        mine_count -= 1
      else
        mine_bag << false
      end
    end

    mine_bag.shuffle!

    grid_indices.each do |row|
      grid_indices.each do |col|
        pos = [row, col]
        self[pos] = Tile.new(@grid, pos, mine_bag.pop)
      end
    end
  end

  def render
    @grid.each { |row| puts row.join(" ") }
    nil
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end 

  def reveal(pos)
    self[pos].reveal
  end

  def toggle_flag(pos)
    self[pos].toggle_flag
  end
end

board = Board.new(10)

board.reveal([0,0])
board.render

