class Tile
  def initialize(board, mine=false)
    @board = board
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
end