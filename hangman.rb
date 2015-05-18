# Brandi & Michelle - HANGMAN
require "colorize"

class Hangman

  def initialize

    @answer_bank = ["cupcake", "spaghetti", "cookie", "hamburger", "pizza", "sandwich", "crackers", "salad", "cheese", "burrito"]
    @guesses = 4 # number of allowed incorrect guesses
    @num_correct = 0 # counter to compare to length of answer
    @current_answer = @answer_bank[rand(@answer_bank.length)] # string (of answer)
    @current_answer_array = @current_answer.split(//) # array (of answer)
    @fillable_answer = [] # array (of blanks to be filled in by answer)
    @alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @already_guessed = [] # array (to store already guessed letters)

    @current_answer_array.length.times do |x|
      @fillable_answer[x] = " _ "
    end

    draw_art
    print_word
    play
  end # initialize

  # DRAWS THE ASCII ART
  def draw_art
    # parts of our hangman to be drawn
    head = "(_)".colorize(:red)
    arms = "\\|/".colorize(:light_black)
    torso = "|".colorize(:purple)
    legs = "/ \\".colorize(:magenta)

    art = <<-END
|     _________
|     |/      |
|     |
|     |
|     |
|     |
|     |
|_____|___________

    END

    if @guesses == 3
      art = <<-END
|     _________
|     |/      |
|     |      #{head}   - "Is it getting hot in here?"
|     |
|     |
|     |
|     |
|_____|___________

    END

    elsif @guesses == 2
      art = <<-END
|     _________
|     |/      |
|     |      #{head}   - "Should I wave my life goodbye?"
|     |      #{arms}
|     |
|     |
|     |
|_____|___________

    END

    elsif @guesses == 1
      art = <<-END
|     _________
|     |/      |
|     |      #{head}   - "I can't feel my legs."
|     |      #{arms}
|     |       #{torso}
|     |
|     |
|_____|___________

    END

    elsif @guesses == 0
      art = <<-END
|     _________
|     |/      |
|     |      #{head}   - "You need to learn
|     |      #{arms}             how to spell,
|     |       #{torso}                you killed me!"
|     |      #{legs}
|     |
|_____|___________

    END
    end

    puts art
  end #draw_art

  # PRINTS TEXT INFO
  def print_word
    print "WORD: "
    puts @fillable_answer.join
    puts "" # inserts blank lines
    puts "Letters Guessed: #{@already_guessed.join(" ")}"
    puts "Incorrect Guesses Left: #{@guesses}"
    puts ""
  end # print_word

  # PLAYING THE GAME
  def play
    while @guesses > 0

      print "Type a letter: "
      letter = gets.chomp.downcase
      wrong = true

      if letter.length == 1

        until @alphabet.include?(letter.upcase)
          puts "You must put an actual letter please."
          print "Type a letter: "
          letter = gets.chomp.downcase
        end

        @current_answer_array.length.times do |x|
          if @current_answer_array[x] == letter
            @fillable_answer[x] = " #{letter} "
            wrong = false

            unless @already_guessed.include?(letter)
              @num_correct = @num_correct + 1
            end
          end
        end

        @already_guessed.push(letter)

        if wrong == true
          @guesses = @guesses - 1
        end

      elsif @current_answer == letter
        win
        exit
      else
        @guesses = @guesses - 1
      end

      draw_art
      print_word

      if @num_correct == @current_answer.length
        win
        exit
      end

    end # while

    puts "The word was #{@current_answer}."
    exit

  end # play

  # WINNING ART
  def win
    puts <<-END
|     _________
|     |/
|     |           - "Hooray! You saved me
|     |      (_)        from losing my head!"
|     |      \\|/
|     |       |
|     |      / \\
|_____|___________

    END
  end # win

end # class Hangman

Hangman.new
