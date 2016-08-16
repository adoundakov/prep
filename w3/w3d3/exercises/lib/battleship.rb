require "byebug"
require_relative "board.rb"
require_relative "player.rb"
require_relative "computer.rb"
require_relative "ship.rb"

class BattleshipGame
  attr_reader :board, :player, :player2, :board2, :current_player,
              :current_board

  def initialize(player, board, player2 = nil, board2 = nil)
    @player = player
    @board = board
    @rows = board.grid.length
    @cols = board.grid[0].length
    @player2 = player2
    @current_player = player
    @current_board = board

    if player2
      @player2 = player2
      @board2 = board2
      @current_board = board2
    end
  end

  def play
    puts "Welcome to BATTLESHIP"
    if player2
      puts "Starting two player game!"
      two_player
    else
      puts "Starting one player game!"
      one_player
    end
    puts "Game Over!"
  end

  def one_player
    setup_phase(player, board) if board.empty?
    while game_over? == false || board.empty?
      play_turn
    end
  end

  def two_player
    setup_phase(player, board) if board.empty?
    setup_phase(player2, board2) if board2.empty?

    while game_over? == false || board.empty? || board2.empty?
      play_turn(current_player, current_board)
      switch_players
    end
    display_board(board)
    display_board(board2)
  end

  def setup_phase(player, board)
    puts "#{player.name}, please set up your ships."
    player.set_ships(board)
  end

  def play_turn(player = @current_player, board = @current_board)
    display_board(board)
    pos = player.get_play(@rows, @cols, board)
    if board[*pos] == :x || board[*pos] == :o
      puts "Already guessed!"
      play_turn
    end
    attack(pos)
  end

  def game_over?
    test_2 = false
    if player2
      test_2 = board2.won?
    end
    return board.won? || test_2
  end

  def attack(position)
    if current_board[*position] == nil
      puts "Splash!"
      current_board[*position] = :x
    elsif board[*position] == :s
      puts "BOOM!"
      current_board[*position] = :o
    end
  end

  def switch_players
    if current_player == @player
      @current_player = player2
      @current_board = board
    elsif current_player == @player2
      @current_player = player
      @current_board = board2
    end
  end

  def count
    board.count
  end

  def display_board(board)
    board.display
  end

  def self.default_game
    p1 = HumanPlayer.new
    board1 = Board.new
    p2 = ComputerPlayer.new
    board2 = Board.new

    BattleshipGame.new(p1, board1, p2, board2)
  end
end
