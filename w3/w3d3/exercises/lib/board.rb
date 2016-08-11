class Board
  attr_reader :grid

  def initialize(grid=nil)
    if grid
      @grid = grid
    else
      @grid = Board.default_grid
    end
  end

  def display
    puts "Current Board:"
    puts "Ships left: #{count}"
    grid.each do |row|
      hidden_row = []
      row.each do |pos|
        if pos == :x || pos == :o
          hidden_row << pos
        else
          hidden_row << '-'
        end
      end
      puts hidden_row.join('  ')
    end
  end

  def display_full
    grid.each do |row|
      printable_row = []
      row.each do |pos|
        if pos == nil
          printable_row << '-'
        else
          printable_row << pos
        end
      end
      puts printable_row.join('  ')
    end
  end

  def place_random_ship
    raise Exception.new("Board Full") if full?

    pos = [rand(grid.length), rand(grid[0].length)]
    if empty?(pos)
      self[*pos] = :s
    else
      place_random_ship
    end
  end

  def count
    count = 0
    @grid.each do |row|
      row.each do |pos|
        count += 1 if pos == :s
      end
    end
    count
  end

  def won?
    grid.each do |row|
      return false if row.any? { |el| el == :s }
    end
    true
  end

  def self.default_grid
    Array.new(10) {Array.new(10)}
  end

  def empty?(position=nil)
    if position
      return true if self[*position] == nil
      return false
    else
      grid.each do |row|
        return false if row.any? { |el| el != nil }
      end
      return true
    end
  end

  def full?
    grid.each do |row|
      return false if row.any? { |el| el == nil }
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
