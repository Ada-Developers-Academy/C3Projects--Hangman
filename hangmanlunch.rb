require "colorize"

class Hangman

  def initialize
    @answer_array = populate_answer
    @guess_array = populate_guess_array
    @paper = []
    @top_row =      "|    _________"
    @second_row =   "|     |/      "
    @middle_row =   "|     |       "
    @base_row =     "| ____|___ word: #{@guess_array.join(" ")}"
    @misses = 0
    @incorrect_array =[]

    #remove this line to actually play-- leaving it for testing purposes
    puts "Answer: " + @answer_array.join

    start
  end

  # create paper
  def draw_paper
    @paper.each do |row|
      puts row
    end
  end

  def start
    puts "\nLet's play Hangman!!\n"

    #this kicks off the game loop in "play" method below
    @now_playing = true

    # creates empty scaffold (in the paper array)
    @paper.push(@top_row, @second_row, @base_row)

    5.times do
      @paper.insert(2, @middle_row)
    end

    # draws initial empty scaffold
    draw_paper

    #starts asking for guesses
    play
  end

  def play

    while @now_playing
      # asks for user guess and checks their guess
      get_guess
      check_guess(@letter_guess)
    end
  end


  def get_guess
    puts "\nGuess a letter! Or you can give up and type 'quit'."
    # asks for user input (i.e. their letter guess)
    @letter_guess = gets.chomp.downcase

    acceptable_range = ("a".."z")

    # allows user to quit the game
    if @letter_guess == "quit"
      exit

    # controls for unexpected user input
    elsif acceptable_range.include?(@letter_guess) == false
      puts "We're working with letters here. Come on...".red.bold
    end
    return @letter_guess
  end

  def check_guess(guess)

    # if their guess is in the answer...
    if @answer_array.include?(@letter_guess)

        # finding out which index has the match
        @answer_array.each_index do |index|

          if @answer_array[index] == @letter_guess
          # Replace "_" with the correct letter in guess_array
            @guess_array.delete_at(index)
            @guess_array.insert(index, @letter_guess)

            # reassigns this part of the scaffold with the updated guess_array
            @base_row =     "| ____|___ word: #{@guess_array.join(" ").upcase}"
            @paper[7] = @base_row

            # checks for a "win". If there are no blanks left, you win.
            if @guess_array.include?("_") == false
              misses_print

              win
            end
          end
        end

        # reprints the paper
        misses_print

    # if there is not a match at all (i.e. incorrect guess)
    else
        @misses += 1
        # adds the incorrect guess to the incorrect_array to display
        @incorrect_array.push(@letter_guess.upcase)

        misses_print
        puts "\nI'm sorry. That is an incorrect guess."
    end
  end

  def misses_print
    @misses_array = []

    @miss_one =   "|     |/      |".green
    @miss_two =   "|     |      (_)".cyan
    @miss_three = "|     |       |".light_red
    @miss_four =  "|     |      \\|".light_blue
    @miss_five =  "|     |      \\|/".magenta
    @miss_six =   "|     |       |".light_yellow
    @miss_seven = "|     |      / ".light_green
    @miss_eight = "|     |      / \\".light_cyan
    @incorrect_guesses = "Incorrect guesses: #{@incorrect_array.join(" ")}"

  # Start of @paper                        # End result of @paper
  # [0]    |    _________                  # [0]    |    _________
  # [1]    |     |/                        # [1]    |     |/      |
  # [2]    |     |                         # [2]    |     |      (_)
  # [3]    |     |                         # [3]    |     |      \|/
  # [4]    |     |                         # [4]    |     |       |
  # [5]    |     |                         # [5]    |     |      / \
  # [6]    |     |                         # [6]    |     |
  # [7]    | ____|___ word: _ _ _ _ _ _    # [7]    | ____|___ word: _ O _ D O _
  # [8]                                    # [8]   Incorrect guesses

    @misses_array.push(@miss_one, @miss_two, @miss_three, @miss_four, @miss_five, @miss_six, @miss_seven, @miss_eight, @incorrect_guesses)

    if @misses == 1
      @paper[1] = @misses_array[0]

    elsif @misses == 2
      @paper[2] = @misses_array[1]

    elsif @misses == 3
      @paper[3] = @misses_array[2]

    elsif @misses == 4
      @paper[3] = @misses_array[3]

    elsif @misses == 5
      @paper[3] = @misses_array[4]

    elsif @misses == 6
      @paper[4] = @misses_array[5]

    elsif @misses == 7
      @paper[5] = @misses_array[6]

    elsif @misses == 8
      @paper[5] = @misses_array[7]

      draw_paper
      lose
    end

    @paper[8] = @incorrect_guesses
    draw_paper
  end

  def lose
    puts "Sorry, you lose.".red.blink
    exit
  end

  def win
    puts "Yay! You win.".magenta.blink
    exit
  end

  def populate_answer
    answer_bank =["attention", "cherries", "dancer", "competitor", "nose", "straw", "teeth", "spark", "pants", "bamboo",
      "memory", "climb", "instrument", "thread", "harmonica"]

    selected_answer = answer_bank[rand(0...15)]
    answer_array = selected_answer.chars.to_a
    @guess_length = answer_array.length.to_i

    return answer_array
  end


  def populate_guess_array
    blank_guesses = []

    # Makes an array with the number of spaces as are in the answer array
    @guess_length.times do |_|
      blank_guesses.push("_")
    end
    return blank_guesses
  end
end

Hangman.new
