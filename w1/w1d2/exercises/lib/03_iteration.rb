def factors(num)
  facts = [1]
  check = 2
  while check <= num / 2
    facts << check if num % check == 0
    check += 1
  end
  facts << num
end

class Array
  def bubble_sort!(&prc)
    return self if self.length <= 1
    if prc.nil?
      self.default_bubble
    else
      changed = true
      while changed
        changed = false
        idx = 0
        while idx < self.length - 1
          check = idx + 1
          num1 = self[idx]
          num2 = self[check]
          if prc.call([num1, num2]) == 1
            changed = true
            self[idx], self[check] = self[check], self[idx]
          end
          idx += 1
        end
      end
      self
    end
  end

  def default_bubble
    changed = true
    while changed
      changed = false
      x = 0
      while x < self.length - 1
        y = x + 1
        if self[x] > self[y]
          self[x],self[y] = self[y],self[x]
          changed = true
        end
        x += 1
      end
    end
    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

def substrings(string)
  results = []
  left_idx = 0
  while left_idx < string.length
    results << string[left_idx]
    right_idx = left_idx + 1
    while (right_idx < string.length) && (right_idx != nil)
      results << string[left_idx..right_idx]
      right_idx += 1
    end
    left_idx += 1
  end
  results.uniq
end

def subwords(word, dictionary)
  strings = substrings(word)
  words = []
  strings.each do |string|
    words << string if dictionary.include?(string)
  end
  words.uniq
end

def doubler(array)
  return array.map { |num| num * 2  }
end

class Array
  def my_each(&prc)
    idx = 0
    while idx < self.length
      prc.call(self[idx])
      idx += 1
    end

    self
  end

  def my_map(&prc)
    result = []
    self.my_each do |el|
      result << prc.call(el)
    end
    result
  end

  def my_select(&prc)
    result = []
    self.my_each do |el|
      result << el unless prc.call(el) == false
    end
    result
  end

  def my_inject(&prc)
    accumulator = self.first
    self[1..-1].my_each do |el|
      accumulator = prc.call(accumulator, el)
    end
    accumulator
  end
end


def concatenate(strings)
  strings.inject('') {|sentence, word| sentence << word}
end
