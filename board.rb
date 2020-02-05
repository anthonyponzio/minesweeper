require_relative "tile"

class Board
  def self.random_mine_bag(size)
    mine_bag = []
    mine_count = size

    (size * size).times do
      mine_bag << (mine_count > 0)
      mine_count -= 1
    end

    mine_bag.shuffle!
  end

  attr_reader :grid

  def initialize(size)
    @grid = Array.new(size) { Array.new(size) }
    fill_grid(size)
  end

  def fill_grid(size)
    grid_indices = (0...size)
    mine_bag = Board.random_mine_bag(size)

    grid_indices.each do |row|
      grid_indices.each do |col|
        render
        pos = [row, col]
        self[pos] = Tile.new(self, pos, mine_bag.pop)
      end
    end
  end

  def render
    system("clear")
    @grid.each { |row| puts row.join(" ") }
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, value)
    row, col = pos
    @grid[row][col] = value
  end
  
  def size
    @grid.size
  end

  def reveal(pos)
    self[pos].reveal
  end

  def toggle_flag(pos)
    self[pos].toggle_flag
  end
end
