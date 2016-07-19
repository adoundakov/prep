require 'byebug'

class TowersOfHanoi
  attr_reader :towers, :start

  def initialize(disks = 3)
    @start = (1..disks).to_a.reverse
    @towers = [@start.dup, [], []]
  end

  def play
    until won?
      render
      puts "Please select a tower to pick from:"
      from_tower = gets.chomp.to_i
      puts "Please select a tower to move to:"
      to_tower = gets.chomp.to_i
      move(from_tower - 1, to_tower - 1)
    end
    render
    puts "Yay! You win!"
  end

  def move(from_tower, to_tower)
    if valid_move?(from_tower, to_tower)
      disk = @towers[from_tower].pop
      @towers[to_tower] << disk
    else
      puts "Invalid Move."
    end
  end

  def valid_move?(from_tower, to_tower)
    bottom_disk = @towers[to_tower].last
    top_disk = @towers[from_tower].last

    return true if bottom_disk == nil
    return false if top_disk == nil
    return true if bottom_disk > top_disk
  end

  def render
    puts "\n"
    @towers.each_with_index do |tower, index|
      puts "Tower #{index + 1}:"
      puts tower.join('     ')
    end
    puts "\n"
  end

  def won?
    return true if @towers[1] == @start || @towers[2] == @start
    false
  end
end
