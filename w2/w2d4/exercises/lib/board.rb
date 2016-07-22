class Board
  attr_accessor :grid

  def initialize(pre_set=nil)
    if pre_set == nil
      @grid = Array.new(3) {Array.new(3)}
    else
      @grid = pre_set
    end
  end

  def place_mark(pos, mark)
    self[*pos] = mark
  end

  def empty?(pos)
    return false if self[*pos] != nil
    true
  end

  def winner
    cols = grid.transpose
    diagonals = [[self[0,0],self[1,1],self[2,2]],
                [self[0,2],self[1,1],self[2,0]]]
    lanes = [*grid, *cols, *diagonals]
    marks = [:X, :O]

    marks.each do |mark|
      if lanes.any? { |lane| lane == [mark, mark, mark] }
        return mark
      end
    end

    return nil
  end

  def over?
    if winner != nil
      return true
    elsif tied?
      return true
    else
      return false
    end
  end

  def tied?
    return false if winner != nil
    
    grid.each do |row|
      row.each do |pos|
        return false if pos == nil
      end
    end
    true
  end

  def [](row, col)
    @grid[row][col]
  end

  def []=(row, col, mark)
    @grid[row][col] = mark
  end
end
