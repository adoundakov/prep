require_relative "ship.rb"

class HumanPlayer
  attr_reader :name

  def initialize(name = "Player One")
    @name = name
  end

  def get_play(rows, cols, board)
    puts("#{name}'s turn. Please make an attack. (row, col)")
    position = process_move(gets.chomp)
    return position
  end

  def set_ships(board)
    Ship.fleet.each do |ship|
      board.display_full
      puts "Please set the #{ship.name} of length #{ship.size}"
      position, orientation = get_ship_position(ship, board)
      ship.place(position, orientation, board)
    end
  end

  def get_ship_position(ship, board)
    puts "Enter an orientation (h / v)"
    orientation = gets.chomp
    puts "Enter the left/top coordinate"
    position = process_move(gets.chomp)

    if valid_placement?(position, orientation, ship.size, board.grid)
      return [position, orientation]
    else
      puts "Error, please re-enter info."
      get_ship_position(ship, board)
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

  def process_move(move)
    position = []
    move.split(',').each do |el|
      position << (el.strip.to_i) - 1
    end
    position
  end
end
