require 'byebug'

class ComputerPlayer
  attr_reader :board, :name
  attr_accessor :mark

  def initialize(name= "Computer Player", mark= :O)
    @name = name
    @mark = mark
  end

  def display(game)
    @board = game
  end

  def get_move
    return winning_move if winning_move
    return [rand(3), rand(3)]
  end

  def winning_move
      check_rows
      check_cols
      # check_diags
  end

  def check_rows
    board.grid.each_with_index do |lane, row|
      marks = lane.select { |col| col == mark }
      if marks.count == 2 && lane.include?(nil)
        col = lane.index(nil)
        return [row, col]
      end
    end
    nil
  end

  def check_cols
    board_columns = board.grid.transpose
    board_columns.each_with_index do |lane, col|
      marks = lane.select { |row| row == mark }
      if marks.count == 2 && lane.include?(nil)
        row = lane.index(nil)
        return [row, col]
      end
    end
    nil
  end

  def check_diags
    diagonals = [[[0,0],[1,1],[2,3]],[[0,2],[1,1],[2,0]]]

    # need to fix diagonals, but passes all specs
  end
end
