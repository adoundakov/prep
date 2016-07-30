class HumanPlayer
  attr_reader :name

  def initialize(name = "Player One")
    @name = name
  end

  def get_play
    position = []
    puts("#{name}'s turn. Please make an attack (row, col)")
    pos = gets.chomp
    pos.split(',').each do |el|
      position << (el.strip.to_i) - 1
    end

    position
  end
end
