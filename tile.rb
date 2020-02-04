class Tile
  def initialize(mine=false)
    @mine = mine
    @flagged = false
    @revealed = false
  end

  def reveal
    @revealed = true
  end
end