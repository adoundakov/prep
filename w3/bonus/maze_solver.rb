class Maze
  attr_reader :maze
  def initialize(raw_maze)
    raw_lines = File.readlines(raw_maze)
    @maze = raw_lines.map {|line| line.strip.split}
  end
end

if __FILE__ == 'maze.rb'
  file = ARGV[0]
  maze = Maze.new(file)
  maze.solve
end
