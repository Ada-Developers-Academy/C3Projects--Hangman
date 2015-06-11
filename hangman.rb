# Hangman
# Pair project w/ Amira Hailemariam

require 'colorize'

class Hangman

    # array of arrays, each is a mistake level drawing
  DRAWINGS = [
            [
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
  WORD_LIST = %w{cat dog egg horse donkey elephant pig monkey iguana cow goat unigoat eggplant mouse dragon phoenix}

  def initialize
    @game_word = pick_word
    @wrong_letters = []
    @errors = 0
    
    make_array_of_slots

    start
  end

  def make_array_of_slots
    @num_of_slots = @game_word.length
    @array_of_slots = Array.new(@num_of_slots, "_ ")
  end

  def pick_word
    random_word = WORD_LIST.sample
    return random_word
  end

  def start
    puts "Welcome to Hangman."
    puts "Please type your whole word or letter guess. No numbers, punctuation, or spaces."
    # uncomment the following line for aid in development
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

    exit if input == "quit" || input == "exit"

    validate_input(input)
  end

  def validate_input(input)
    valid = input.chars.find { |letter| !("a".."z").include?(letter) } ? false : true

    return input if valid
  
    puts "Error:".colorize(:red) + " Please only use letters. No numbers, punctuation, or spaces."
    get_guess
  end

  def check_guess(guess_letter)
    # check word input
    if guess_letter.length > 1
      if guess_letter == @game_word
        # fill in array of slots with letters of guess word
        guess_letter.split("").each_with_index do |letter, index|
          @array_of_slots[index] = letter + " "
        end
        # multi-letter guesses that are incorrect count as a mistake
      else
        @wrong_letters.push(guess_letter)
        @errors += 1
        puts "\nThat is not the correct word."
      end
    # guess_letter is just a letter
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
          puts "\nYou already made that incorrect guess."
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
      if @errors >= DRAWINGS.length - 1
        lose
      end
    end
  end

  def win
    @now_playing = false
    puts "\nCongrats, you won."
  end

  def lose
    @now_playing = false
    puts "\nYou FAILED. And got hanged."
  end


  # ---------------------------------
  # Visual Methods
  def draw_tree(error_level)
    top_space
    puts DRAWINGS[error_level].join("\n")
  end

  def draw_slots
    top_space
    puts @array_of_slots.join
  end

  def draw_wrong_guesses
    top_space
    puts "Wrong guesses: " + @wrong_letters.join(" ")
  end

  def update_board
    draw_tree(@errors)
    draw_slots
    draw_wrong_guesses
  end

  def top_space
    puts "\n"
  end

end

Hangman.new
