require_relative "board"

class Game
  def initialize
    @board = board.new(10)
  end

  def get_command
    print "\nEnter a command (`f` to flag, `r` to reveal):"
    gets.chomp
  end

  def get_pos
    print "\nEnter a position (format `#,#` | e.g `2,0`):"
    gets.chomp.split(",").map(&:to_i)
  end

  def make_move(command, pos)
    case command
    when "f" || "F"
      puts "command was to place flag"
    end
  end

  def run
    @board.render
    command = get_command
    pos = get_pos  
  end
end