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
    row, col = @pos
    positions = []

    (row-1..row+1).each do |row_i|
      (col-1..col+1).each do |col_i|
        positions << [row_i, col_i]
      end
    end

    positions.select do |adj_pos|
      next false if adj_pos == @pos
      adj_pos.none? { |i| (0...@grid.size).include?(i) }
    end
  end
end
