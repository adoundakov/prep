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
    valid = false
    until valid
      r_row = rand(3)
      r_col = rand(3)
      valid = true if board.grid[r_row][r_col] == nil
    end

    return [r_row, r_col]
  end

  def winning_move
      return check_rows if check_rows != nil
      return check_cols if check_cols != nil
      return check_diags if check_diags != nil
      nil
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
    l_diag = {[0,0] => board[*[0,0]],
              [1,1] => board[*[1,1]],
              [2,2] => board[*[2,2]]}

    r_diag = {[0,2] => board[*[0,2]],
              [1,1] => board[*[1,1]],
              [2,0] => board[*[2,0]]}

    [l_diag, r_diag].each do |hash|
      marks = hash.values.select { |value| value == mark }
      if marks.count == 2 && hash.values.include?(nil)
        return hash.key(nil)
      end
    end

    nil
  end
end
