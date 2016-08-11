class HumanPlayer
  attr_reader :name

  def initialize(name = "Player One")
    @name = name
  end

  def get_play(rows, cols, board)
    puts("#{name}'s turn. Please make an attack. (row, col)")
    move = gets.chomp
    position = process_move(move)
    return position
  end

  def set_ships(board)
    5.times do
      board.display_full
      puts "Please place a ship."
      pos = gets.chomp
      position = process_move(pos)
      board[*position] = :s
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
