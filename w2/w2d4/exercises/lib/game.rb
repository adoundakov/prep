require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_reader :current_player, :board

  def initialize(player1, player2)
    @player_one = player1
    @player_two = player2
    @board = Board.new

    @player_one.mark = :X
    @player_two.mark = :O
    @current_player = @player_one
  end

  def switch_players!
    if current_player == @player_one
      @current_player = @player_two
    else
      @current_player = @player_one
    end
  end

  def play_turn
    puts "Current player: #{current_player.name}"
    current_player.display(board)
    move = current_player.get_move
    board.place_mark(move, current_player.mark)
    switch_players!
  end

  def play
    @current_player = @player_one
    puts "Welcome to Tic-Tac-Toe!"
    puts "Player One is: #{@player_one.name}"
    puts "Player Two is: #{@player_two.name}"

    play_turn until board.over?

    display_game
    
    puts "Game Over!"
    puts "Tie Game!" if board.tied?
    if board.winner == @player_one.mark
      puts "#{@player_one.name} won!"
    elsif board.winner == @player_two.mark
      puts "#{@player_two.name} won!"
    end
  end

  def display_game
    board.grid.each do |row|
      puts row.join(' | ')
    end
  end
end
