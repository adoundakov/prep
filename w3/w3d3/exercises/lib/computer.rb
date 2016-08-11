require 'byebug'
class ComputerPlayer
  attr_reader :name

  def initialize(name="Computer")
    @name = name
  end

  def get_play(rows, cols, board)
    puts "#{name}'s turn. Making an attack."
    scan(rows, cols, board).sample
  end

  def scan(rows, cols, board)
#    debugger
    available_spots = []
    x = 0
    while x < rows
      y = 0
      while y < cols
        if board.grid[x][y] == nil or board.grid[x][y] == :s
          available_spots << [x,y]
        end
        y += 1
      end
      x += 1
    end
    available_spots
  end

  def set_ships(board)
    5.times do
      board.place_random_ship
    end
  end
end
