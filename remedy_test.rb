require 'remedy'
include Remedy


class Cursor
  def initialize(grid_size)
    @interaction = Interaction.new
    @cursor_pos = [0,0]
    @index_range = (0...grid_size)
  end

  def input_loop
    @interaction.loop do |key|
      row, col = @cursor_pos

      case key.name
      when :w, :up
        p "up"
        row -= 1
      when :a, :left
        p "left"
        col -= 1
      when :s, :down
        p "down"
        row += 1
      when :d, :right
        p "right"
        col += 1
      when :space
        puts "revealing at #{@cursor_pos}"
        return ["reveal", @cursor_pos]
      when :f
        puts "flagging at #{@cursor_pos}"
        return ["flag", @cursor_pos]
      end
      
      update_cursor_pos([row, col])
    end
  end

  def update_cursor_pos(pos)
    row, col = pos
    
    if @index_range.include?(row) && @index_range.include?(col)
      @cursor_pos = [row, col]
    end
  end
end

cursor = Cursor.new(20)
cursor.input_loop
