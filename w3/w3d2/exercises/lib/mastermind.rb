# All done, but needs refactoring and fix of RSPEC test bug for
# get_guess

class Code
  attr_reader :pegs
  PEGS = {'R' => 'red', 'O' => 'orange', 'Y' => 'yellow',
          'G' => 'green', 'B' => 'blue', 'P' => 'purple'}

  def initialize(pegs_array)
    @pegs = pegs_array
  end

  def self.parse(string)
    string.strip
    pegs_array = string.upcase.split('')

    #debugger

    pegs_array.each do |peg|
      unless PEGS.include?(peg)
        raise Exception.new('Invalide Peg Color')
      end
    end

    Code.new(pegs_array)
  end

  def self.random
    rand_array = []

    4.times {rand_array << PEGS.keys.sample}

    Code.new(rand_array)
  end

  def [](idx)
    pegs[idx]
  end

  def exact_matches(guess)
    idx = 0
    matches = 0
    while idx < pegs.length
      matches += 1 if guess.pegs[idx] == pegs[idx]
      idx += 1
    end

    matches
  end

  def near_matches(guess)
    # bug: counts repeated right color wrong index as near_matches
    # should only count each color once per time it appears in the
    # secret string
    near_matches = 0
    secret_count = peg_count

    # maybe put into another method?
    guess_count = {}

    guess.pegs.each do |peg|
      guess_count[peg] = 0
    end

    guesses = guess.pegs

    # => EW . needs refactoring.
    guesses.each_with_index do |guess_peg, idx|
      if pegs.include?(guess_peg) && pegs[idx] != guess_peg
        if guess_count[guess_peg] < secret_count[guess_peg]
          near_matches += 1
          guess_count[guess_peg] += 1
        end
      end
    end

    near_matches
  end

  def peg_count
    peg_hash = {}
    @pegs.each do |peg|
      if peg_hash[peg]
        peg_hash[peg] += 1
      else
        peg_hash[peg] = 1
      end
    end

    peg_hash
  end

  def ==(other_code)
    if other_code.class != Code
      return false
    elsif pegs == other_code.pegs
      return true
    else
      return false
    end
  end

  def compare(guess)
    revealed = []

    pegs.each_with_index do |peg, index|
      guess_peg = guess.pegs[index]
      if peg == guess_peg
        revealed << peg
      else
        revealed << '-'
      end
    end

    revealed.join
  end
end

class Game
  attr_reader :secret_code

  def initialize(secret = Code.random)
    @secret_code = secret
    @turns = 10
    @guess = nil
  end

  def get_guess
    # code works perfectly, but fails the RSPEC test for
    # some random reason!
    puts "Enter a guess:"
    guess = gets.chomp
    Code.parse(guess)
  end

  def display_matches(guess)
    puts "There are #{@secret_code.near_matches(guess)} near matches."
    puts "There are #{@secret_code.exact_matches(guess)} exact matches."
    puts @secret_code.compare(guess)
  end

  def play
    puts "Welcome to Mastermind."
    until over?
      @guess = get_guess
      display_matches(@guess)
      @turns -= 1
    end

    puts "Game over!"
  end

  def over?
    return true if @turns <= 0
    return true if secret_code == @guess
    return false
  end
end
