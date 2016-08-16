# leave options to enable comp and humans to place ships.
# the auto placing logic can be in the comp class

class Ship
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def place(position, orientation, board)
    if orientation == 'h'
      # iterate through lane from start and set appropriate number of
      # slots to :s, using the self.size attribute
    else
      # transpose so everything is an array of cols, then apply same
      # logic as the horizontal block above. 
    end
  end

  def self.fleet
    [
      Ship.carrier,
      Ship.battleship,
      Ship.submarine,
      Ship.cruiser,
      Ship.patrol_boat
    ]
  end

  def self.carrier
    Ship.new(:carrier, 5)
  end

  def self.battleship
    Ship.new(:battleship, 4)
  end

  def self.submarine
    Ship.new(:submarine, 3)
  end

  def self.cruiser
    Ship.new(:cruiser, 2)
  end

  def self.patrol_boat
    Ship.new(:patrol_boat, 1)
  end
end
