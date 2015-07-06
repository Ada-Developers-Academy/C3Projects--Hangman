# Hangman
require "colorize"

class Hangman

  def initialize
    @answer = populate_answer
    # Displayed line to fill in correct guesses
    @answer_line = answer_line
    # count of wrong answers
    @wrong_count = 0
    @letter_array = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    @letters_guessed = []

    start
    draw_board
    play
  end

  def start
    puts "Welcome to Star Trek Hangman! Good luck!"
    # Keeps track of game play
    @now_playing = true
  end

# ------------------
# Create answer
  def populate_answer
    answer_array = ["PICARD", "GUINAN", "WORF", "WARP", "ENGAGE", "ENTERPRISE", "DATA", "ROMULAN", "VULCAN", "BETAZOID", "KLINGON", "FEDERATION", "REPLICATOR", "DARMOK", "HOLODECK", "PHASER", "TRICORDER", "BEAM", "TRANSPORTER"]
    return answer_array.sample
  end

# ------------------
# Visual methods

# draws board depending on number of wrong answers
  def draw_board
    if @wrong_count == 0
      puts """
    ___________________          _-_
    \\==============_=_/ ____.---'---`---.____
                \\_ \\    \\----._________.----/
                  \\ \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

"""
    elsif @wrong_count == 1
      puts """
                                 _-_
                        ____.---'---`---.____
                \\_ \\    \\----._________.----/
                  \\ \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

""".cyan
    elsif @wrong_count == 2
      puts """
                                 _-_
                        ____.---'---`---.____
                   \\    \\----._________.----/
                    \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

      """.blue
    elsif @wrong_count == 3
      puts """
                                _-_
                       ____.---'---`---.____
                       \\----._________.----/
                        /  /   `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

      """.yellow
    elsif @wrong_count == 4
      puts """
                                   _-_
                          ____.---'---`---.____
                          \\----._________.----/
                          /  /    `-_-'

      """.magenta
    elsif @wrong_count == 5
      puts """
                                   _-_
                          ____.---'---`---.____
                          \\----._________.----/
                                  `-_-'

      """.red
    else
      lose
    end

    # Show modified answer line.
    puts @answer_line.join
  end

# Creates blank answer line
  def answer_line
      @answer_line = Array.new(@answer.length, ' _ ')
  end

# ------------------

# Enter and check answer
  def play
    # split answer word into array consisting of each letter.
    letters = @answer.split("")

    # Check until answer is complete (guesses have revealed all letters)
    until @answer_line.join == @answer
      # Get a guess
      puts "Guess a letter, please:"
      input = gets.chomp.upcase

      # Allow user to quit
      if input == "QUIT"
        exit
      end

      # Error if invalid input given.
      until input.length == 1 && @letter_array.include?(input.upcase)
        puts "You're better than this. Please enter ONE LETTER, thanks."
        input = gets.chomp.upcase
      end

      # display guesses thus far
      if input.length == 1 && @letter_array.include?(input.upcase)
        @letters_guessed.push(input)
        puts "Letters Guessed: #{@letters_guessed.join(" ")}"
      end

      # Check input against answer
      # If correct, replace _ with input letter
      if letters.include?(input)
        letters.each_index do | index |
          if letters[index] == (input)
            letters[index] = "@"
            @answer_line[index] = input
          end
        end
      else
        @wrong_count += 1
      end

      draw_board
    end

    win

  end

# --------------------
# Winning and Losing

  # Output if win
  def win
    puts "YOU WIN!!! The Federation thanks you!!!".red.blink
    puts """
  ___________________          _-_
  \\==============_=_/ ____.---'---`---.____
              \\_ \\    \\----._________.----/
                \\ \\   /  /    `-_-'
            __,--`.`-'..'-_
           /____          ||
                `--.____,-'

  """.green.blink
  end

  # Output if lose
  def lose
    puts "Sorry, warp core breach! You lose!".red.blink
    exit
  end

end


Hangman.new
