class Tile
  def initialize(grid, mine=false)
    @grid = grid
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

  def to_s
    if @flagged
      "F"
    elsif @revealed
      @mine ? "M" : "_"
    else
      "*"
    end
  end

  def pos
    return @pos if @pos
    pos = nil
    @grid.each_with_index do |row, row_i|
      col_i = row.index(self)
      break @pos = [row_i, col_i] if col_i
    end
    @pos
  end

  def neighbors
    # find self in board and find neighbors (all tiles around tile)
    @pos
  end
end