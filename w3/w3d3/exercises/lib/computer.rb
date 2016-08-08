require_relative "board.rb"

class ComputerPlayer
  attr_reader :name

  def initialize(name="Computer")
    @name = name
  end

  def get_play(rows, cols)
    puts "#{name}'s turn. Making an attack."
    [rand(rows), rand(cols)]
  end
end

# ways to make the comp smarter:

# find nearest hit, go from there and guess 1 above, below, left, right.
# above only works for ship sizes >1, for smaller you can guess in the
# opposite corner from your last hit. so if you hit a ship in Q1, can
# assume they didnt put many in that quadrant?

# hard to do this way, since wouldnt necessarily correlate to any real
# world advantage, still fully random.
