class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players=nil)
    unless players
      raise Exception.new("No Players entered")
    end
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = []
  end

  def setup
    word_length = referee.pick_secret_word
    guesser.register_secret_length(word_length)
    word_length.times {@board << '_'}
  end

  def take_turn
    display_board
    guess = guesser.guess(board)
    match_indices = referee.check_guess(guess)
    update_board(guess, match_indices)
    guesser.handle_response(guess, match_indices)
  end

  def update_board(guess, match_indices)
    match_indices.each do |idx|
      @board[idx] = guess
    end
  end

  def display_board
    puts "Secret Word: #{board.join}"
  end

  def guessed?
    board.none? {|e| e == '_'}
  end

  def play_phase_1
    puts "Welcome to Hangman. (PHASE 1)"
    setup
    take_turn until guessed?
    puts "Game over!"
    display_board
  end
end

class HumanPlayer
  attr_reader :secret_word_length, :guesses

  def initialize
    contents = File.readlines("dictionary.txt")
    @dictionary = contents.map {|line| line.strip}
    @guesses = []
  end

  def handle_response(guess, match_indices)
    if match_indices.empty?
      puts 'Bad guess, no matches!'
    elsif guesses.include?(guess)
      puts 'Already guessed!'
    else
      puts "Good guess! Found #{match_indices.length} matches."
    end
  end

  def guess(board)
    puts "Already guessed: #{guesses}"
    puts "Please enter a guess: "
    gets.chomp
  end

  def check_guess(guess)
    word = ''
    (1..secret_word_length).each do |num|
      word << "#{num}:_ "
    end
    puts word
    puts "Computer guessed '#{guess}'."
    puts "Please enter the correct indexes, separated by a space."
    puts "If none hit <enter>"
    input = gets.chomp
    process(input)
  end

  def process(input)
    return [] if input == ""
    split_input = input.split(' ')
    match_indices = split_input.map { |e| (e.to_i) - 1 }
    match_indices
  end

  # What is the point of this method? I get for the computerplayer
  # but not for the human?
  def register_secret_length(length)
    puts "The length of the secret word is: #{length}"
  end

  def pick_secret_word
    puts "Please enter the length of your secret word:"
    @secret_word_length = gets.chomp.to_i
  end
end

class ComputerPlayer
  attr_reader :secret_word_length, :guesses

  def initialize(dictionary=nil)
    if dictionary
      @dictionary = dictionary
    else
      contents = File.readlines("dictionary.txt")
      @dictionary = contents.map { |line| line.strip }
    end
    @guesses = []
    @candidate_words = @dictionary
  end

  def pick_secret_word
    @secret_word = @dictionary.sample
    @secret_word_length = @secret_word.length
  end

  def check_guess(guess)
    letters = @secret_word.split('')
    match_indices = []
    letters.each_with_index do |letter, index|
      match_indices << index if letter == guess
    end

    match_indices
  end

  def register_secret_length(length)
    @secret_word_length = length
    trim_potentials
  end

  def guess(board)
    ComputerPlayer.alphabet.sample
  end

  def handle_response(guess, match_indices)
  end

  def trim_potentials
    pot_words = @candidate_words.select {|e| e.length == @secret_word_length}
    @guess_bank = pot_words
  end

  def filter_potentials(board)
    # would use this to find words that have the right letters in the
    # right spots. Could use regex (do they take wildcards?)
    # - Could use hash with position --> letter
  end

  def self.alphabet
    ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p',
     'q','r','s','t','u','v','w','x','y','z']
  end
end
