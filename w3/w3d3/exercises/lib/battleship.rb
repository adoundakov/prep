class BattleshipGame
  attr_reader :board, :player, :player2, :board2, :current_player

  def initialize(player, board, player2 = nil)
    @player = player
    @player.board = board
    @board = @player.board

    @player2 = player2
    @board2 = nil
    @current_player = nil

    if player2
      @player2 = player2
      @board2 = @player2.board
      @current_player = @player
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
    setup_phase if board.empty?

    while game_over? == false || board.empty?
      play_turn
    end
  end

  def two_player
    setup_phase(player) if board.empty?
    setup_phase(player2) if board2.empty?

    while game_over? == false || board.empty? || board2.empty?
      play_turn(current_player)
      switch_players
    end
  end

  def setup_phase(player = @player)
    puts "#{player.name}, please set up your ships."
    player.set_ships
  end

  def play_turn(player = @player)
    display_board(player)
    flag = false
    until flag == true
      pos = player.get_play(@num_rows, @num_cols)
      if @board[*pos] == :x or @board[*pos] == :o
        puts "Already guessed!"
        flag = false
      else
        flag = true
      end
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
    if @board[*position] == nil
      puts "Splash!"
      @board[*position] = :x
    elsif @board[*position] == :s
      puts "BOOM!"
      @board[*position] = :o
    end
  end

  def count(player = @player)
    player.board.count
  end

  def display_board(player)
    player.board.display
  end

# will delete this after specs are done
  def self.newgame
    new_grid = Array.new(5) {Array.new(5)}
    board = Board.new(new_grid)
    p1 = HumanPlayer.new('Alex')

    game = BattleshipGame.new(p1, board)
    5.times {board.place_random_ship}

    game
  end
end

# TO - DO

# re-write default game in Battleship.rb
# test out full game starting with empty boards for each player
# flesh out setup and display phases for each player
#
