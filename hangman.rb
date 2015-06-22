require "Colorize"

class Hangman

  def initialize

    #this runs at the beginning and calls lots of other methods

    # initialized variables
    @answer = pick_answer
    # User has 7 wrong guesses before game over
    @no_of_guesses = 0
    @blanks_array = answer_to_blanks
    @guessed_letters = [ ]

    # methods we need to call in the flow of the game
    start
    art
    get_guess

  end

  def start
    puts "Welcome to Hangman! Type " + "'quit'".colorize(:red) + " at any time to exit."
  end


# creates an answer from the array that is randomized
  def pick_answer
    # randomly pick the answer from this array
    library = ["cat", "dog", "mouse", "letter", "elephant",
      "bottomless", "house", "polecat", "coffee", "apple",
      "laptop", "caramel", "sushi", "computer", "television"]
    @answer = library.sample
    return @answer
  end

  def answer_to_blanks
    # convert the @answer to same number of blanks
    # so we can display that clue for the user
    num_of_blanks = @answer.length
    @blanks = "_" * num_of_blanks
    puts @blanks

    # split up the blank array into individual "_"  strings
    # so we can change each one individually
    @blanks_array = @blanks.split(//)
    return @blanks_array

  end


  def get_guess
    # gets user input
    puts "\nGuess a letter: "
    @guess = gets.chomp

    if @guess.upcase == "QUIT"
      exit
    end

    valid_guess
    check_answer
  end

  # validates the guess to make sure it's a through z
  def valid_guess
    until  (("A".."Z").include? @guess) || (("a".."z").include? @guess)
      puts "Please enter a letter from A to Z."
      @guess = gets.chomp
    end
  end


  def check_answer
    # compares guess to the answer

    # answer letters go into an array
    answer_array = @answer.split(//)
    # checks the guess against each letter (including duplicates)
    answer_array.each_index do |index|
      # in guessed letter is included in answer,
      # replaces the "_" in the answer array with the guessed letter
      if @guess == answer_array[index]
        @blanks_array[index] = @guess.upcase
      end
    end

    # increments the number of wrong guesses by checking
    # if the answer array has the guessed letter in it
    if answer_array.include?(@guess) == false
      @no_of_guesses += 1
    end

    # methods to call
    guessed_letters
    puts "You have #{8-@no_of_guesses} guesses left!"
    win?
    lose?
  end



# This is a visual aid for the player to
  # see what letter's they've already guessed
  def guessed_letters
    @guessed_letters.push(@guess)
    puts "Guessed Letters: #{@guessed_letters}"
  end

  # --------------------------------
  #art ^_^
    def art
      puts "
    |     _________
    |     |/      |
    |     |      (_)
    |     |      \\|/
    |     |       |
    |     |      / \\
    |     |
    | ____|___".colorize(:light_green)
    puts "Word: #{@blanks}"
    end
# ------------------------------------------
# checks to see if user won/lost

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
    else
    end
  end

# --------------------------------------
#endgame

  def win
    # displays if you win
    puts "__________________________"
    puts "Congrats, you have won.  Whoo hoo!"
    puts "
  |     _________
  |     |/      |
  |     |
  |     |
  |     |
  |     |
  |     |
  | ____|___".colorize(:blue)
    exit
  end


  def lose
      puts "__________________________"
      puts "Oh NOOO! You have lost.  Please restart and try again. :("
      puts "
    |     _________
    |     |/      |
    |     |      (_)
    |     |      \\|/
    |     |       |
    |     |      / \\
    |     |   xxxxxxxx
    | ____|___".colorize(:red)
    puts "The answer was: #{@answer}."

    exit
  end

end

Hangman.new
