require "Colorize"

class Hangman

  def initialize
    # List of possible game words. They are randomly selected during initialize.
    @word_list =  ["w h a l e", "f l a g", "d o g", "f o r e s t",
    "b r a v e", "r o s e", "g i f t", "s t a y", "a x", "d o l p h i n"]

    # ASCII representations of the hangman graphics
    @hanger_start   = """
    |     _________
    |     |/      |
    |     |
    |     |
    |     |
    |     |
    |     |
    | ____|___
    """
    @hanger_head = """
    |     _________
    |     |/      |
    |     |      (∞)
    |     |
    |     |
    |     |
    |     |
    | ____|___
    """.colorize(:red)

   @hanger_body = """

    |     _________
    |     |/      |
    |     |      (∞)
    |     |       |
    |     |       |
    |     |
    |     |
    | ____|___
   """.colorize(:red)

    @hanger_arm1 = """
    |     _________
    |     |/      |
    |     |      (∞)
    |     |       |\\
    |     |       |
    |     |
    |     |
    | ____|___
    """.colorize(:red)

    @hanger_arm2 = """
    |     _________
    |     |/      |
    |     |      (∞)
    |     |      /|\\
    |     |       |
    |     |
    |     |
    | ____|___
    """.colorize(:red)

    @hanger_leg1 = """
    |     _________
    |     |/      |
    |     |      (∞)
    |     |      /|\\
    |     |       |
    |     |      /
    |     |
    | ____|___
    """.colorize(:red)

    @hanger_leg2 = """
    |     _________
    |     |/      |
    |     |      (∞)
    |     |      /|\\
    |     |       |
    |     |      / \\
    |     |
    | ____|___
    """.colorize(:red)

    @winner = """
    HURAHH!!!! I'm alive!
           (∞)
           \\|/
            |
           / \\
    """.colorize(:light_blue)

    # This creates an array of possible ASCII outcomes as the user makes mistakes or wins
    @hanger_list = [@hanger_head, @hanger_body, @hanger_arm1, @hanger_arm2, @hanger_leg1, @hanger_leg2, @winner]

    start
    answer
    puts "Word: ".colorize(:light_blue) + blank
    play
  end

  # Prompts the user to begin a new game
  def start
    puts "Let's play Hangman!"
    puts "To start hit enter"
    user = gets
    if user.length == 1
    puts @hanger_start
    puts "Looking for a word for you... one sec!"
    puts "To quit during gameplay, type 'quit'"
    sleep 1
    end
  end

  # Randomly generates answer word
  def answer
    @random_word = @word_list[rand(0...@word_list.length)]
    #puts "#{@random_word}".colorize(:black)
    return @random_word
  end

  def blank
    # Turns the answer into a letter array
    @answer_array = @random_word.split(" ")
    # Creates a "blank array" of underscores
    blank_count = @answer_array.length
    @blank_array = []
    underscore = "_ "
      while @blank_array.length != blank_count
        @blank_array.push(underscore)
      end
    # Creates a string of underscores and future correct guesses
    @blank_array.join
  end

  # Gameplay begins
  def play
    # The user input is an array (since we're comparing it to an answer array)
    @user_input = []
    # Assumes that the user is wrong unless they meet certain conditions below
    correct_guess = false
    # The wrong_answer variable helps us keep track of wrong answer attempts and change the ASCII art
    wrong_answer = 0

    # The user can only make 5 incorrect guesses
    while wrong_answer < 5
      @input = gets.chomp.downcase
    # Quit option
      if @input == "quit"
        exit
      end
    # Detects a correct answer
      (0...@answer_array.length).each do |index|
        if  @input == @answer_array[index]
            @blank_array[index] = @input + " "
            puts "Good for you!".colorize(:light_blue)
            puts  @blank_array.join
            correct_guess = true
            # Check for winner (no underscores left in the blank array)
            if  @blank_array.join.include?("_") == false
                puts "YOU WON, CONGRATULATIONS!".on_blue.underline
                puts @hanger_list[6]
              exit
            end
          # Breaks the conditional so that correct_guess isn't reset to false
          break
        else
          correct_guess = false
        end
      end

      # Detects a wrong answer
      if correct_guess == false
        puts "Wrong!".colorize(:red)
        puts @hanger_list[wrong_answer]
        # Increments wrong answer by 1
        wrong_answer += 1

        # Checks to see if guesses are all up
        if wrong_answer == 5
          puts "Unfortunately you lost!".on_red.underline
          puts @hanger_list[5]
        end

      end
    end
  end
end

#Runs a new game of Hangman automatically
Hangman.new
