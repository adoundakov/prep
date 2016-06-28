class Book
  def initialize
  end

  def title
    @title
  end

  def title=(title)
    @title = process(title)
  end

  def process(title)
    not_capitalizeable = ['the','a','an','and','or','in','of']
    words = title.split
    new_words = []
    idx = 0
    while idx < words.length
      if idx == 0
        new_words << words[idx].capitalize
      elsif not_capitalizeable.include?(words[idx])
        new_words << words[idx]
      else
        new_words << words[idx].capitalize
      end
      idx += 1
    end
    new_words.join(' ')
  end
end
