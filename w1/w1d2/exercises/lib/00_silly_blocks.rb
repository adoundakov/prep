def reverser(&string)
  rev_string = ''
  words = string.call.split
  words.each do |word|
    rev_string << word.reverse + ' '
  end
  rev_string.strip
end

def adder(add = 1, &num)
  num.call + add
end

def repeater(num = 1, &block)
  num.times do
    block.call
  end
end
