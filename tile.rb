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

  def adjacent_positions
    return @adjacent_positions if @adjacent_positions

    row, col = pos
    @adjacent_positions = []

    validate_i = Proc.new do |i, other_i|
      i != other_i &&
      (0...@grid.size).include?(i)
    end

    adj_rows = (row-1..row+1).to_a.select { |i| validate_i.call(i, row) }
    adj_cols = (col-1..col+1).to_a.select { |i| validate_i.call(i, col) }

    adj_rows.each do |adj_row|
      adj_cols.each do |adj_col|
        @adjacent_positions << [adj_row, adj_col]
      end
    end

    @adjacent_positions
  end
end
