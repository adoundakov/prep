#!/usr/bin/env ruby

class Maze
  def initialize(raw_maze)
    @maze_name = raw_maze.delete('.txt')
    raw_lines = File.readlines(raw_maze)
    raw_lines.map! { |line| line.chomp.split('') }

    @maze = Array.new(raw_lines.length) {Array.new}

    raw_lines.each_with_index do |line, row|
      line.each_with_index do |char, col|
        @maze[row] << Square.new(char, [row,col])
      end
    end

    @open_list = []
    @closed_list = []
    @current_square, @tgt_square = find('S'), find('E')
  end

  def solve
    while true
      add_adjacent
      break if @open_list.include?(@tgt_square)
      find_next
    end

    build_path
  end

  def find(char)
    @maze.each do |line|
      line.each do |square|
        return square if square.contents == char
      end
    end
  end

  def find_next
    scores = @open_list.map { |square| calc_F_score(square) }

    next_pos = scores.index(scores.min)
    next_square = @open_list[next_pos]
    next_square.parent = @current_square

    @closed_list << next_square
    @open_list.delete(next_square)

    @current_square = next_square
    @open_list = []
  end

  def calc_F_score(square)
    row, col = square.pos
    tgt_row , tgt_col = @tgt_square.pos
    square.f_score = (tgt_row - row).abs + (tgt_col - col).abs
  end

  def add_adjacent
    row, col = @current_square.pos
    possible_moves = [ @maze[row+1][col],
                       @maze[row-1][col],
                       @maze[row][col-1],
                       @maze[row][col+1]
                      ]
    possible_moves.each do |square|
      unless square.contents == '*' || @closed_list.include?(square)
        @open_list << square
      end
    end
  end

  def build_path
    @closed_list.each {|square| square.mark}

    solved_maze = @maze.map do |line|
      line.map { |square| square.contents }
    end

    File.open("#{@maze_name}_solution.txt", 'w') do |file|
      solved_maze.each do |line|
        file.puts line.join
      end
    end
  end
end

class Square
  attr_reader :contents, :pos
  attr_accessor :f_score, :parent

  def initialize(contents = nil, pos = [])
    @contents = contents
    @parent = nil
    @f_score = 0
    @pos = pos
  end

  def mark
    @contents = 'X'
  end
end

if __FILE__ == $0
  Maze.new(ARGV[0]).solve
end
