require 'byebug'

class Maze
  def initialize(raw_maze)
    raw_lines = File.readlines(raw_maze)
    raw_lines.map! { |line| line.chomp.split('') }

    @maze = raw_lines.map do |line|
      line.map { |char| Square.new(char) }
    end

    @open_list = []
    @closed_List = []
    @current = {square: nil, pos: nil}
  end

  def solve
    @current[:square], @current[:pos] = find_start
  end

  def find_start
    debugger
    
    row = 0
    @maze.each do |line|
      col = 0
      line.each do |square|
        break if square.contents == 'S'
        col += 1
      end
      row += 1
    end

    pos = [row, col]
    [self[*pos] , pos]
  end

  def find_end
  end

  def find_next
  end

  def add_adjacent
  end

  def [](row, col)
    @maze[row][col]
  end

# delete this after done with program? or could use it to write to file?
  def display
    maze.each do |line|
      line.each do |square|
        print square.contents
      end
      print "\n"
    end
  end
end

class Square
  attr_reader :parent, :contents, :f_score

  def initialize(contents = nil)
    @contents = contents
    @parent = nil
    @f_score = 0
  end
end

# if __FILE__ == 'maze.rb'
#   file = ARGV[0]
#   maze = Maze.new(file)
#   maze.solve
# end
