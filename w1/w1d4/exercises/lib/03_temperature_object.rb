class Temperature
  attr_accessor :type, :temp
  def initialize(options)
    @type = options.keys[0]
    @temp = options[@type]
  end

  def in_fahrenheit
    return @temp if @type == :f
    (@temp * 9.0 / 5.0) + 32.0
  end

  def in_celsius
    return @temp if @type == :c
    (@temp - 32.0) * 5.0 / 9.0
  end

  def self.from_celsius(start_temp)
    self.new(:c => start_temp)
  end

  def self.from_fahrenheit(start_temp)
    self.new(:f => start_temp)
  end
end

# Extra way to define the subclasses

class Celsius < Temperature
  def initialize(start_temp)
    Temperature.new(:c => start_temp)
    @temp = start_temp
    @type = :c
  end
end

class Fahrenheit < Temperature
  def initialize(start_temp)
    Temperature.new(:f => start_temp)
    @temp = start_temp
    @type = :f
  end
end
