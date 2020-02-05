require_relative "tile"

class Board
  def self.random_mine_bag(size, mine_count)
    mine_bag = []
    mine_count = mine_count

    (size * size).times do
      mine_bag << (mine_count > 0)
      mine_count -= 1
    end

    mine_bag.shuffle!
  end

  attr_reader :grid, :mine_count

  def initialize(size, mine_count)
    @mine_count = mine_count
    @grid = Array.new(size) { Array.new(size) }
    fill_grid
    @game_lost = false
  end

  def fill_grid
    grid_indices = (0...size)
    mine_bag = Board.random_mine_bag(size, mine_count)

    grid_indices.each do |row|
      grid_indices.each do |col|
        render
        pos = [row, col]
        self[pos] = Tile.new(@grid, pos, mine_bag.pop)
      end
    end
  end

  def render
    system("clear")
    
    puts
    @grid.each_with_index do |row, row_i|
      border = "  "
      puts border + row.join(" ") + border
    end
    puts
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
    tile = self[pos]
    tile.reveal
    @game_lost = true if tile.blown_up?
  end

  def toggle_flag(pos)
    self[pos].toggle_flag
  end

  def win?
    @grid.all? do |row|
      row.all? { |tile| tile.mine ? !tile.blown_up? : tile.revealed }
    end
  end

  def lose?
    @game_lost
  end
end
