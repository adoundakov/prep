require_relative "ship.rb"

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
    # need to add testing of overlap between each ship.
    # at beginning, using ship.size attribute. 
    orientations = ['h', 'v']
    rows = board.grid.length
    cols = board.grid[0].length

    Ship.fleet.each do |ship|
      orient = orientations.sample
      if orient == 'h'
        short_cols = cols - ship.size
        position = [rand(rows, short_cols)]
      else
        short_rows = rows - ship.size
        position = [rand(short_rows, cols)]
      end
      ship.place(position, orient, board)
    end
  end
end
