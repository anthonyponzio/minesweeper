class Tile
  def initialize(mine=false)
    @mine = mine
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true unless @flagged
  end
  
  def flag
    @flagged = true unless @revealed
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