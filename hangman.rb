# Hangman
# Pair project w/ Amira Hailemariam

require 'colorize'

class Hangman
  attr_reader :game_word, :num_of_slots
  attr_accessor :working_answer, :wrong_letters

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

  MESSAGES = {
    wrong_letter: "That is not the right letter.",
    wrong_letter_already: "You already guessed that wrong letter.",
    wrong_word: "That is not the correct word.",
    wrong_word_already: "You already guessed that wrong word.",
    right_letter: "Yup, that's one of the right letters.",
    right_letter_already: "You already figured out that letter.",
    invalid_input: "Error:".colorize(:red) + " Please only use letters. No numbers, punctuation, or spaces.",
    win: "Congrats, you won.",
    lose: "You FAILED. And got hanged."
  }

  def initialize
    @game_word = pick_word
    @num_of_slots = game_word.length
    @wrong_letters = []
    # @errors = 0
    
    make_array_of_slots
    working_answer

    start
  end

  def make_array_of_slots
    @array_of_slots = Array.new(num_of_slots, "_")
  end

  def working_answer
    @array_of_slots.join
  end

  def pick_word
    random_word = WORD_LIST.sample
    return random_word
  end

  def start
    puts "Welcome to Hangman."
    puts "Please type your whole word or letter guess. No numbers, punctuation, or spaces."
    # uncomment the following line for aid in development
    puts "Answer: #{game_word}"

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
    return input unless input.chars.find { |letter| !("a".."z").include?(letter) }
  
    print_message(:invalid_input)
    get_guess
  end

  def wrong_guess_action(guess)
    wrong_letters << guess
  end

  def fill_in_letter(guess)
    (0...num_of_slots).each do |index|
        @array_of_slots[index] = guess if game_word[index] == guess
      end
  end

  def check_word_guess(guess)
    return print_message(:wrong_word_already) if wrong_letters.include?(guess)

    if guess == game_word  # fill in array of slots with letters of guess word
      guess.chars.each_with_index { |letter, index| @array_of_slots[index] = letter }
    else
      wrong_guess_action(guess)
      print_message(:wrong_word)
    end
  end

  def check_letter_guess(guess)
    return print_message(:right_letter_already) if working_answer.include?(guess)
    return print_message(:wrong_letter_already) if wrong_letters.include?(guess)

    if game_word.include?(guess)
      fill_in_letter(guess)
      print_message(:right_letter)
    else
      wrong_guess_action(guess)
      print_message(:wrong_letter)
    end
  end

  def check_guess(guess)
    return check_word_guess(guess) if guess.length > 1

    check_letter_guess(guess)
  end


  # ---------------------------------
  # Winning and Losing

  def check_win
    win if working_answer == game_word
    lose if wrong_letters.length >= DRAWINGS.length - 1
  end

  def win
    @now_playing = false
    print_message(:win)
  end

  def lose
    @now_playing = false
    print_message(:lose)
  end


  # ---------------------------------
  # Visual Methods
  def draw_tree(error_level)
    top_space
    puts DRAWINGS[error_level].join("\n")
  end


  def draw_slots
    top_space
    puts @array_of_slots.join(" ")
  end

  def draw_wrong_guesses
    top_space
    puts "Wrong guesses: " + wrong_letters.join(" ")
  end

  def update_board
    draw_tree(wrong_letters.length)
    draw_slots
    draw_wrong_guesses
  end

  def top_space
    puts "\n"
  end

  def print_message(context)
    top_space
    puts "--> #{MESSAGES[context]}"
  end
end

Hangman.new
