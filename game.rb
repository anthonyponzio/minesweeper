require_relative "board"
require_relative "cursor"

class Game
  def initialize
    @board = Board.new(20, 25)
    @cursor = Cursor.new(20)
  end

  # def valid_command?(input)
  #   input.downcase == "f" || input.downcase == "r"
  # end
  
  # def valid_pos?(input)
  #   input.size == 2 &&
  #   input.all? { |i| (0...@board.size).include?(i) }
  # end

  # def get_command
  #   print "\nEnter a command (`f` to flag, `r` to reveal): "
  #   gets.chomp
  # end

  # def get_pos
  #   print "\nEnter a position (format `#,#` | e.g `2,0`): "
  #   gets.chomp.split(",").map(&:to_i)
  # end

  # def get_input
  #   command = get_command
  #   pos = get_pos
    
  #   until valid_command?(command) && valid_pos?(pos)
  #     puts "Invalid command or position, try again!"
  #     command = get_command
  #     pos = get_pos
  #   end

  #   [command, pos]  
  # end

  def make_move(command, pos)
    case command
    when "flag"
      @board.toggle_flag(pos)
    when "reveal"
      @board.reveal(pos)
    end
  end

  def game_over?
    @board.lose? || @board.win?
  end

  def run
    until game_over?
      render_prc = Proc.new { |cursor_pos| @board.render(cursor_pos) }

      render_prc.call(@cursor.cursor_pos)
      inputs = @cursor.input_loop(render_prc)
      make_move(*inputs)
    end

    puts "Game over!"
  end
end

game = Game.new
game.run