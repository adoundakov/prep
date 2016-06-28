class Temperature
  def initialize(options)
    @type = options.keys[0]
    @temp = options[@type]
  end

  def in_fahrenheit
    return @temp if @type == :f
    (@temp * 9.0/5.0) + 32.0
  end

  def in_celsius
    return @temp if @type == :c
    (@temp * 5.0/9.0) - 32.0
  end
end
