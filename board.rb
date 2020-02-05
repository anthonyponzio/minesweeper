require_relative "tile"

class Board
  attr_reader :grid

  def initialize(grid_size)
    @grid = Array.new(grid_size) { Array.new(grid_size) }
    fill_grid(grid_size + 1)
  end

  def fill_grid(mine_count)
    grid_range = (0...@grid.size)
    grid_range.each do |row|
      grid_range.each do |col|
        if mine_count > 0
          is_mine = [true, false].sample
          mine_count -= 1 if is_mine
        end

        pos = [row, col]
        self[pos] = Tile.new(@grid, pos, is_mine)
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

