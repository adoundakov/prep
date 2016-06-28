class Timer
  attr_accessor :seconds
  def initialize
    @seconds = 0
  end

  def time_string
    secs = @seconds % 60
    minutes = (@seconds / 60) % 60
    hours = @seconds / 3600

    "%02d" % hours + ":%02d" % minutes + ":%02d" % secs
  end
end
