require 'byebug'
class Hangman
  attr_reader :guesser, :referee, :board

  def initialize(players = nil)
    raise Exception.new("No Players entered") unless players
    @guesser = players[:guesser]
    @referee = players[:referee]
    @board = []
  end

  def setup
    word_length = referee.pick_secret_word
    guesser.register_secret_length(word_length)
    word_length.times { @board << '_' }
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
    board.none? { |e| e == '_' }
  end

  def play_phase_1
    puts 'Welcome to Hangman. (PHASE 1)'
    setup
    take_turn until guessed?
    puts 'Game over!'
    display_board
  end
end

class HumanPlayer
  attr_reader :secret_word_length, :guesses

  def initialize
    contents = File.readlines('dictionary.txt')
    @dictionary = contents.map(&:strip)
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

  def guess(_board)
    puts "Already guessed: #{guesses}"
    puts 'Please enter a guess: '
    gets.chomp
  end

  def check_guess(guess)
    word = ''
    (1..secret_word_length).each do |num|
      word << "#{num}:_ "
    end
    puts word
    puts "Computer guessed '#{guess}'."
    puts 'Please enter the correct indexes, separated by a space.'
    puts 'If none hit <enter>'
    input = gets.chomp
    process(input)
  end

  def process(input)
    return [] if input == ''
    split_input = input.split(' ')
    match_indices = split_input.map { |e| e.to_i - 1 }
    match_indices
  end

  # What is the point of this method? I get for the computerplayer
  # but not for the human?
  def register_secret_length(length)
    puts "The length of the secret word is: #{length}"
  end

  def pick_secret_word
    puts 'Please enter the length of your secret word:'
    @secret_word_length = gets.chomp.to_i
  end
end

class ComputerPlayer
  attr_reader :secret_word_length, :candidate_words, :board, :guesses

  def initialize(dictionary = nil)
    if dictionary
      @dictionary = dictionary
    else
      contents = File.readlines('dictionary.txt')
      @dictionary = contents.map(&:strip)
    end
    @guesses = []
    @board = []
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
    length.times { @board << nil }
    trim_candidates
  end

  def guess(board)
    @board = board
    guess, * = guess_list.max_by { |_, value| value }
    guess
  end

  def handle_response(guess, match_indices)
    @guesses << guess
    if match_indices.empty?
      trim_candidates
    else
      match_indices.each do |idx|
        @board[idx] = guess
      end
      trim_candidates
    end
  end

  def trim_candidates
    @candidate_words.delete_if { |e| e.length != secret_word_length }
    @candidate_words.delete_if { |e| match?(e) == false }
  end

  def guess_list
    guess_list = Hash.new(0)
    @candidate_words.each do |word|
      word.split('').each do |letter|
        guess_list[letter] += 1 unless board.include?(letter)
      end
    end

    guess_list
  end

  def match?(word)
    (0..secret_word_length).each do |idx|
      if !board[idx].nil? && board[idx] != word[idx]
        return false
      elsif board[idx].nil? && guesses.include?(word[idx])
        return false
      end
    end
    true
  end
end
