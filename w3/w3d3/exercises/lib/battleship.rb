require 'byebug'

class BattleshipGame
  attr_reader :board, :player

  def initialize(player, board)
    @board = board
    @player = player
  end

  def play
    puts "Welcome to BATTLESHIP"
    while game_over? == false || board.empty?
      display_status
      play_turn
    end

    puts "Game over!"
  end

  def play_turn
    pos = player.get_play
    attack(pos)
  end

  def attack(position)
    if @board[*position] == nil
      puts "Splash!"
      @board[*position] = :x
    elsif @board[*position] == :s
      puts "BOOM!"
      @board[*position] = :o
    end
  end

  def display_status
    board.display
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def self.newgame
    new_grid = Array.new(5) {Array.new(5)}
    board = Board.new(new_grid)
    p1 = HumanPlayer.new('Alex')

    game = BattleshipGame.new(p1, board)
    5.times {board.place_random_ship}

    game
  end
end
