# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  number = rand(1..100)
  guess = nil
  guesses = 0

  until guess == number
    puts "Guess a number: "
    guess = gets.chomp.to_i
    if guess > number
      puts "#{guess} is too high!"
    elsif guess < number
      puts "#{guess} is too low!"
    end
    guesses += 1
  end

  puts "Yay! Number was #{number}. You took #{guesses} guesses."
end

def shuffle_file
  puts "Please enter a source file: "
  source_file = gets.chomp
  contents = File.readlines(source_file)
  contents = contents.shuffle

  File.open("#{source_file}-shuffled.txt" , 'w') do |f|
    contents.each do |line|
      f.puts line
    end
  end
end
