class Hangman

  def initialize
    @answer = pick_answer
    @no_of_guesses = 0
    @blanks_array = answer_to_blanks

    start
    puts @answer #temporary!!
    art
    get_guess

  end

  def start
    puts "Welcome to Hangman!"
  end

  def pick_answer
    # randomly pick the answer from the library
    library = ["cat", "dog", "mouse", "letter", "elephant", "bottomless", "house", "polecat", "coffee", "apple"]
    @answer = library.sample

    return @answer
  end

  def answer_to_blanks
    # convert the answer to the number of blanks of the chosen word
    num_of_blanks = @answer.length
    @blanks = "_" * num_of_blanks
    puts @blanks
    @blanks_array = @blanks.split(//) # turns the string into an array of strings for each character

    return @blanks_array

  end

  def get_guess
    # gets user input
    puts "\nGuess a letter: "
    @guess = gets.chomp

    if @guess == "quit"
      exit
    end
    check_answer
  end

  def check_answer
    # compares the guess to the answer
    answer_array = @answer.split(//)   # turns the answer chosen under pick_answer into an array of strings
    answer_array.each_index do |index|
      if @guess == answer_array[index]

        @blanks_array[index] = @guess.upcase
      end
    end

    if answer_array.include?(@guess) == false
        @no_of_guesses += 1
    end

    win?
    lose?
  end

  def lose?
    if @no_of_guesses <= 7
      print @blanks_array.join(" ")
      get_guess
    else
      lose
    end
  end

  def win?
    if @blanks_array.join.upcase == @answer.upcase
      puts "Answer: #{@answer}"
      win
    end
  end

  def win
    puts "You win!!"
    exit
  end

  def lose
    puts "You lose!"
    exit
  end
#--------------------------------------------
# Art


  def art
    puts "
    |     _________
    |     |/      |
    |     |      (_)
    |     |      \\|/
    |     |       |
    |     |      / \\
    |     |
    | ____|___"
    puts "word: #{@blanks}"
end




end
Hangman.new
