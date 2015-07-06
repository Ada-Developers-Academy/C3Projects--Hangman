# Pair: Alice Rhomieux
require 'colorize'

class Hangman
  def initialize
    @game_word = pick_word
    @wrong_letters = []
    @errors = 0

    # initializes array_of_slots with underscores
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
              "|     |      " + "(_)".red,
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
              "|     |       " + "|".red,
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
              "|     |       " + "|".red,
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
                                    [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      "+ "\\".red + "|",
              "|     |       |",
              "|     |      ",
              "|     |",
              "| ____|___"
            ],
                                                [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      \\|" + "/".red,
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
              "|     |      " + "/ ".red,
              "|     |",
              "| ____|___"
            ],
                                                [
              "|     _________",
              "|     |/      |",
              "|     |      (_)",
              "|     |      \\|/",
              "|     |       |",
              "|     |      / " + "\\ ".red,
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
    puts " "
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
    valid = false

    while !valid
      input.split("").each do |letter|
        # enter and space do not count as mistakes
        # correctly identifies 1st invalid input
        # submits 2nd as a wrong guess
        if letter == " " || !("a".."z").include?(letter)
          puts "\nError:".red + " Please only use letters. No numbers, punctuation, or spaces."
          input = gets.chomp.strip.downcase
        end
      end

      valid = true
      return input
    end
  end

  def check_guess(guess_letter)
    # is guess_letter one lettr or a word/phrase
    if guess_letter.length > 1
      # if a word/phrase
      # check if it's the answer
      if guess_letter == @game_word
        # if it is, fill in array of slots with letters of the answer
        guess_letter.split("").each_with_index do |letter, index|
          @array_of_slots[index] = letter + " "
        end
      end

    # guess_letter is just a letter
    else
      # check if the gussed letter is in game_word
      if @game_word.include?(guess_letter)
        # if letter was already figured out, return message
        if @array_of_slots.join.include?(guess_letter)
          puts "\nYou already figured out that letter."
        end

        # if letter not already guessed and is in game word,
        # fill the corresponding blank with letter
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
          # would be cool if last added body part wasn't still red
          # to show that the guess had no effect
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
    puts " "
  end

end

Hangman.new
