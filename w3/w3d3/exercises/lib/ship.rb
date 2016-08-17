class Ship
  attr_reader :name, :size

  def initialize(name, size)
    @name = name
    @size = size
  end

  def place(position, orientation, board)
    row , col = position
    if orientation == 'h'
      size.times do
        board[row,col] = :s
        col += 1
      end
    else
      size.times do
        board[row,col] = :s
        row += 1
      end
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
