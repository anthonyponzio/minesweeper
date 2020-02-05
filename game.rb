require_relative "board"
require_relative "cursor"

class Game
  def initialize
    @board = Board.new(20, 25)
    @cursor = Cursor.new(20)
  end

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