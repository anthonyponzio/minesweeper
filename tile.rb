class Tile
  def self.adjacent_positions(pos, grid_size)
    row, col = pos
    positions = []

    valid_adj_pos = Proc.new do |adj_pos|
      adj_pos != pos &&
      adj_pos.all? { |i| (0...grid_size).include?(i) }
    end

    adj_rows, adj_cols = (row-1..row+1), (col-1..col+1)

    adj_rows.each do |adj_row|
      adj_cols.each do |adj_col|
        adj_pos = [adj_row, adj_col]
        positions << [adj_row, adj_col] if valid_adj_pos.call(adj_pos)
      end
    end

    positions
  end

  attr_reader :mine

  def initialize(grid, pos, mine=false)
    @grid = grid
    @pos = pos
    @mine = mine
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true unless @flagged
  end

  def toggle_flag
    @flagged = !@flagged unless @revealed
  end

  def neighbors
    return @neighbors if @neighbors

    @neighbors = Tile
      .adjacent_positions(@pos, @grid.size)
      .map { |(row, col)| @grid[row][col] }

    @neighbors
  end

  def neighbor_bomb_count
    @neighbor_bomb_count ||= neighbors.count { |tile| tile.mine }
    @neighbor_bomb_count
  end

  def inspect
    {
      pos: @pos,
      mine: @mine,
      flagged: @flagged,
      revealed: @revealed,
    }
  end

  def to_s
    if @flagged
      "F"
    elsif @revealed
      if @mine
        "M"
      else
        neighbor_bomb_count.to_s
      end
    else
      "*"
    end
  end
end
