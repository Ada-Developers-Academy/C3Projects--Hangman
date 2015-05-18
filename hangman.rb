require 'colorize'

class Hangman
  def initialize
    @game_word = pick_word
    @wrong_letters = []
    @errors = 0
    
    # initialize array_of_slots with underscores
    @num_of_slots = @game_word.length
    @array_of_slots = []
    @num_of_slots.times do 
      @array_of_slots.push("_ ")
    end

    @drawings = [[
              "|     _________",
              "|     |/      |",
              "|     |      ",
              "|     |      ",
              "|     |       ",
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
            [
              "|     _________",
              "|     |/      |",
              "|     |      " + "(_)".colorize(:red),
              "|     |      ",
              "|     |       ",
              "|     |      ",
              "|     |",
              "| ____|___"
            ],

                        [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |       " + "|".colorize(:light_yellow),
              "|     |       ",
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
                                    [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |       |",
              "|     |       " + "|".colorize(:green),
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
                                    [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      "+ "\\".colorize(:cyan) + "|",
              "|     |       |",
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
                                                [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      \\|" + "/".colorize(:blue),
              "|     |       |",
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
                                                [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      \\|/ ",
              "|     |       | ",
              "|     |      " + "/ ".colorize(:magenta),
              "|     |",
              "| ____|___"
            ],
                                                [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      \\|/",
              "|     |       |",
              "|     |      / " + "\\ ".colorize(:light_black),
              "|     |",
              "| ____|___"
]]

    start
  end

  def pick_word
    word_list = %w{cat dog egg horse donkey elephant pig monkey iguana cow goat unigoat eggplant mouse dragon phoenix}
    random_word = word_list.sample
    return random_word
  end

  def start
    puts "Welcome to Hangman."
    puts "Please type your letter guess. No numbers, punctuation, or spaces."
    puts "Answer: #{@game_word}"

    @now_playing = true
    puts "To exit, type: quit."
    draw_tree(0)
   
    draw_slots
    draw_wrong_guesses

    play
  end

  def play
    while @now_playing
      guess = get_guess
      check_guess(guess)
      update_board
      check_win
    end
  end

  # ---------------------------------
  # Guess Methods

  def get_guess
    input = gets.chomp.strip.downcase
    if input == "quit" || input == "exit"
      exit
    else
      guess = validate_input(input)
    end
    return guess
  end

  def validate_input(input)

# This also works, but we like the next solution better
    # valid = true
    # input.split.each do |letter|
    #     if !("a".."z").include?(letter)
    #       valid = false
    #     end
    #   end

    # if valid
    #   return input
    # else
    #   puts "Invalid entry. Please enter only letters (no punctuation)."
    #   get_guess
    # end
# 

    valid = false

    while !valid
      input.split("").each do |letter|
        # enter and space do not count as mistakes
        if letter == " " || !("a".."z").include?(letter)
          puts "Error:".colorize(:red) + " Please only use letters. No numbers, punctuation, or spaces."
          get_guess
        end
      end

      valid = true
      return input
    end
  end

  def check_guess(guess_letter)
    # check word input
    if guess_letter.length > 1
      if guess_letter == @game_word
        # fill in array of slots with letters of guess word
        guess_letter.split("").each_with_index do |letter, index|
          @array_of_slots[index] = letter + " "
        end
        # @array_of_slots = guess_letter.split("")
        # @array_of_slots.each do |letter|
        #   letter += " "
        # end
      end
    # guess_letter is just a letter or 
    else
      # check if guess_letter is in game_word
      if @game_word.include?(guess_letter)
        # if letter was already figured out, return message
        if @array_of_slots.join.include?(guess_letter)
          puts "\nYou already figured out that letter."
        end

        # if letter not already guessed and is in game word, fill the corresponding blank with letter
        (0...@num_of_slots).each do |index|
          if @game_word[index] == guess_letter
            @array_of_slots[index] = guess_letter + " "
          end
        end
      # if guess letter is wrong
      else
        # only if wrong letter was not already guessed
        if !@wrong_letters.include?(guess_letter)
        # adds to wrong letter list
          @wrong_letters.push(guess_letter)
        # increases errors which will draw new body part
          @errors += 1
        else
          # could move this to a better locaton for UI
          puts "\nYou already made that guess."
        end
      end
    end
  end


  # ---------------------------------
  # Winning and Losing

  def check_win
    if @array_of_slots.join.delete(" ") == @game_word
      win
    else
      if @errors >= @drawings.length - 1
        lose
      end
    end
  end

  def win
    @now_playing = false
    puts "Congrats, you won."
  end

  def lose
    @now_playing = false
    puts "You FAILED. And got hanged."
  end


  # ---------------------------------
  # Visual Methods
  def draw_tree(error_level)
    puts "\n"
    @drawings[error_level].each do |row|
      puts row
    end
  end

  def draw_slots
    slots = @array_of_slots.join
    puts "\n#{ slots }"
  end

  def draw_wrong_guesses
    puts "\nWrong guesses: " + @wrong_letters.join(" ")
  end

  def update_board
    draw_tree(@errors)
    draw_slots
    draw_wrong_guesses
  end

end

Hangman.new
