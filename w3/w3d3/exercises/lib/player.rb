class HumanPlayer
  attr_reader :name

  def initialize(name = "Player One")
    @name = name
  end

  def get_play(rows, cols)
    position = []
    puts("#{name}'s turn. Please make an attack.")
    puts "Please use the format 'row , col'"
    pos = gets.chomp
    pos.split(',').each do |el|
      position << (el.strip.to_i) - 1
    end

    return position if valid?(position, rows, cols)
  end

  def valid?(position, rows, cols)
    if position[0] < rows && position[1] < cols
      return true
    else
      return false
    end
  end
end
