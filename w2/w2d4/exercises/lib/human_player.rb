class HumanPlayer
  attr_reader :name

  def initialize(name='Player One')
    @name = name
  end

  def display(board)
    board.grid.each do |row|
      puts row.join(' | ')
    end
  end

  def get_move
    puts "Where to put a mark? (Enter a position)"
    move = gets.chomp
    return to_position(move)
  end

  def to_position(move_string)
    split_string = move_string.split(',')
    position = []
    split_string.each do |el|
      position << el.strip.to_i
    end

    return position
  end
end
