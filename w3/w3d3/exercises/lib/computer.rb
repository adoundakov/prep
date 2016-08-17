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
    Ship.fleet.each do |ship|
      position , orientation = get_ship_position(ship, board)
      ship.place(position, orientation, board)
    end
  end

  def get_ship_position(ship, board)
    orientation = ['h', 'v'].sample
    rows = board.grid.length
    cols = board.grid[0].length
    if orientation == 'h'
      short_cols = cols - ship.size
      ship_row, ship_col = [rand(rows), rand(short_cols)]
      if valid_placement?([ship_row, ship_col], 'h', ship.size, board.grid)
        return [[ship_row,ship_col] , orientation]
      else
        get_ship_position(ship,board)
      end
    else
      short_rows = rows - ship.size
      ship_row, ship_col = [rand(short_rows), rand(cols)]
      if valid_placement?([ship_row, ship_col], 'h', ship.size, board.grid)
        return [[ship_row,ship_col] , orientation]
      else
        get_ship_position(ship,board)
      end
    end
  end

  def valid_placement?(position, orientation, size, grid)
    ship_row , ship_col = position

    if orientation == 'h'
      check = grid[ship_row][ship_col..(ship_col + size)]
      return false if check.any? {|e| e != nil}
    else
      tr_grid = grid.transpose
      check = tr_grid[ship_col][ship_row..(ship_row + size)]
      return false if check.any? {|e| e!= nil}
    end

    return true
  end
end
