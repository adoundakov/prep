require 'Time'

def measure(reps=1, &block)
  elapsed_times = []
  reps.times do
      start = Time.now
      block.call
      elapsed_time = Time.now - start
      elapsed_times << elapsed_time
  end
  average(elapsed_times).to_f
end

def average(times)
    sum = times.inject(:+)
    sum / times.length
end
