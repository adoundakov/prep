def echo(string)
  string
end

def shout(string)
  string.upcase
end

def repeat(string, times=2)
  ((string + ' ')*times).strip
end

def start_of_word(string, length=1)
  string[0,length]
end

def first_word(sentence)
  words = sentence.split
  words.first
end

def titleize(sentence)
  words = sentence.split
  little_words = ['the', 'and', 'of', 'or', 'to', 'over','under']
  title = []
  words.each_with_index do |word, i|
    if little_words.include?(word) && i != 0
      title << word
    else
      title << (word[0].upcase + word[1...word.length])
    end
  end

  title.join(' ')
end
