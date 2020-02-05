class Tile
  attr_reader :mine, :revealed

  def initialize(*args)
    @grid, @pos, @mine = args
    @flagged = false
    @revealed = false
  end

  def reveal
    unless @flagged || @revealed
      @revealed = true
      reveal_neighbors
    end
  end

  def reveal_neighbors
    if neighbor_mine_count == 0
      neighbors.each { |neighbor_tile| neighbor_tile.reveal }
    end
  end

  def toggle_flag
    @flagged = !@flagged unless @revealed
  end

  def neighbors
    @neighbors ||= Tile
      .adjacent_positions(@pos, @grid.size)
      .map { |(row, col)| @grid[row][col] }
  end

  def neighbor_mine_count
    @neighbor_mine_count ||= neighbors.count { |tile| tile.mine }
  end

  def to_s
    if @flagged
      return "F"
    elsif @revealed
      if @mine
        return "M"
      else
        mine_count = neighbor_mine_count
        return mine_count > 0 ? mine_count.to_s : "_"
      end
    end
    
    "?"
  end

  def blown_up?
    @mine && @revealed
  end

  def inspect
    { pos: @pos, string_val: self.to_s }
  end

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
end
