require_relative "board"
require_relative "cursor"

class Game
  def initialize
    @board = Board.new(20, 15)
  end

  def valid_command?(input)
    input.downcase == "f" || input.downcase == "r"
  end
  
  def valid_pos?(input)
    input.size == 2 &&
    input.all? { |i| (0...@board.size).include?(i) }
  end

  def get_command
    print "\nEnter a command (`f` to flag, `r` to reveal): "
    gets.chomp
  end

  def get_pos
    print "\nEnter a position (format `#,#` | e.g `2,0`): "
    gets.chomp.split(",").map(&:to_i)
  end

  def get_input
    command = get_command
    pos = get_pos
    
    until valid_command?(command) && valid_pos?(pos)
      puts "Invalid command or position, try again!"
      command = get_command
      pos = get_pos
    end

    [command, pos]  
  end

  def make_move(command, pos)
    case command
    when "f", "F"
      @board.toggle_flag(pos)
    when "r", "R"
      @board.reveal(pos)
    end
  end

  def game_over?
    @board.lose? || @board.win?
  end

  def run
    until game_over?
      @board.render
      make_move(*get_input)
    end

    puts "Game over!"
  end
end

game = Game.new
game.run