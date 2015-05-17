class Hangman

  def initialize
    # this runs at the beginning and call lost of other methods
    @answer = pick_answer
    start
    puts @answer #temporary!!
    art
    @blanks = answer_to_blanks
    @blanks_array = []
    get_guess
  end

  def start
    puts "Welcome to Hangman!"
  end

  def pick_answer
    # randomly pick the answer from the library
    library = ["cat", "dog", "mouse"]
    @answer = library.sample

    return @answer
  end

  def answer_to_blanks
    #convert the answer to some number of blanks
    num_of_blanks = @answer.length
    @blanks = "_ " * num_of_blanks
    puts @blanks
    @blanks_array = @blanks.split(//)
    return @blanks

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
    answer_array = @answer.split(//)   # turn the element of the array into the guess
    answer_array.each do |letter|
      if @guess == letter
        index = answer_array.index(@guess)
        @blanks_array[index] = letter.upcase
        print @blanks_array.join
      end
    end #but it doesn't keep the previous letters that are correct
    get_guess

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

#---------------------------------------------
# End game

# def win
#   #what happens when you win!!!
# end
#
# def lose
#   #what happens when you lose!!
# end

end
Hangman.new
