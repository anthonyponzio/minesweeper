class Tile
  def initialize(mine=false)
    @mine = mine
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
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