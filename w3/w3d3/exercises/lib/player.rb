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
    # need to move this off into its own method, like get_ship
    # then test for overlap with other ships or going off board
    Ship.fleet.each do |ship|
      board.display_full
      puts "Please set the #{ship.name} of length #{ship.size}"
      puts "Enter the left/top coordinate"
      position = process_move(gets.chomp)
      puts "Enter an orientation (h / v)"
      orientation = gets.chomp
      ship.place(position, orientation, board)
    end
  end

  def process_move(move)
    position = []
    move.split(',').each do |el|
      position << (el.strip.to_i) - 1
    end
    position
  end
end
