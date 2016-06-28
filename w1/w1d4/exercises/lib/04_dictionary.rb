class Dictionary
  def initialize
    @entries = {}
  end

  def entries
    @entries
  end

  def add(input)
    if input.is_a?(Hash)
      key = input.keys[0]
      @entries[key] = input[key]
    elsif input.is_a?(String)
      @entries[input] = nil
    end
  end

  def keywords
    @entries.keys.sort
  end

  def include?(keyword)
    self.keywords.include?(keyword)
  end

  def find(prefix)
    matches = {}
    @entries.each do |keyword, definition|
      if prefix == keyword[0...prefix.length]
        matches[keyword] = definition
      end
    end

    matches
  end

  def printable
    print_out = []
    self.keywords.each do |keyword|
      print_out << (%Q{[#{keyword}] "#{entries[keyword]}"})
    end
    print_out.join("\n")
  end
end
