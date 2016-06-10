def translate(sentence)
  words = sentence.split
  pig_words = []
  words.each do |word|
    pig_words << into_pig(word)
  end

  pig_words.join(' ')
end

def edgecase(word)
  if word[0,2] == 'qu'
    return word[2...word.length] + 'quay'
  elsif word[1,2] == 'qu'
    return word[3...word.length] + word[0,3] + 'ay'
  elsif word[0,3] == 'sch'
    return word[3...word.length] + word[0,3] + 'ay'
  end
end

def into_pig(word)
  vowels = ['a','e','i','o','u']
  if word[0,2] == 'qu' or word[0,3] == 'sch' or word[1,2] == 'qu'
    return edgecase(word)
  elsif vowels.include?(word[0])
    return word + 'ay'
  else
    i = 1
    while i < word.length
      if vowels.include?(word[i])
        return word[i...word.length] + word[0...i] + 'ay'
      end
      i += 1
    end
  end
end
