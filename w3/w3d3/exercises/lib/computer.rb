class ComputerPlayer
  attr_reader :name

  def initialize(name="Computer")
    @name = name
  end

  def get_play(rows, cols)
    [rand(rows), rand(cols)]
  end

  def guess(last_guess=nil)
  end
end


# reference
# def place_random_ship
#  raise Exception.new("Board Full") if full?
#
#  pos = [rand(grid.length), rand(grid[0].length)]
#  if empty?(pos)
#    self[*pos] = :s
#  else
#    place_random_ship
#  end
#end
