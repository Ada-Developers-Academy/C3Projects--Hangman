# Wang & I finished the  breakfast & lunch requirements & part of dinner together.
# We weren't sure we'd have time to finish the dinner requirements, so we focused
# on not penalizing the user for guessing the same letter twice & at the same time
# handling guesses that weren't qualified letters. We did not add difficulty levels.

# This morning, I also added a couple lines to handle guessing the whole word, but
# it's not a fully implemented feature: it doesn't add a piece to the hangman for
# bad guesses. But it does let you skip ahead to winning if you already know the
# word, which is what I was going for. It also throws some errors. >_>

# -*- coding: utf-8 -*-
require "colorize"

# pair project w/ Wang :)

class Hangman
# 1. {0}
# 2. (\
# 3. /)
# 4. ~
# 5. (:)
# 6. _/
# 7. \_

  def initialize
    # hangman board:
    @first        = "     ______       "
    @second       = "    |      |      "
    @third        = "           |      "
    @fourth       = "           |      "
    @fifth        = "           |      "
    @sixth        = "           |      "
    @seventh      = "    _______|___   "
    @eighth       = "   |           |  "
    @ninth        = "                  "
    @tenth        = "  H A N G M A N   " # change based on how many letters, etc

    # start game
    start
  end


  def display_board
    @hangman = [@first, @second, @third, @fourth, @fifth,
                @sixth, @seventh, @eighth, @ninth, @tenth]


    @hangman.each do |line|
      puts line
    end

    puts "\n"
  end


  def set_answer
    possible_answers = [ "potato", "broccoli", "animal", "hotdog",
      "elephant", "cat", "taco", "whale", "walrus", "vulture", "lunch",
      "morning", "evening", "scotch", "whiskey", "salad", "notebook",
      "laptop", "coffee", "caffeine", "solar", "system", "planet",
      "cheerful", "happy", "emotion", "below", "scream", "shout", "jumprope",
      "wizard", "rainfall", "cloudy", "sunlight", "sunshine", "program",
      "hangman", "sticky", "oranges", "eraser", "pencil", "powerful",
      "creative", "cleaning", "nontoxic", "keyboard", "key", "any", "four",
      "badge", "ridge", "cringe", "fringe", "lawful", "lawless", "chaotic",
      "chaos", "crafty", "space", "outside", "outdoor", "cabin", "camping",
      "tentacle", "monster", "you", "our", "hour"
      ]

    # select random word
    which_random_index = rand(0...possible_answers.length)
    @answer = possible_answers[which_random_index]

    # update hangman word display
    @tenth = " _" * @answer.length
  end


  def start
    puts "Let's play hangman!"

    @now_playing = true
    @bad_count = 0
    @good_count = 0
    @letters_guessed = []

    set_answer
    display_board
    play
  end


  def play
    while @now_playing
      guess = get_guess
      check_guess(guess)

      display_board
    end
  end


  def get_guess
    puts "Guess your letter:"

    input = gets.chomp.downcase # downcase == shouldn't matter if cap letters

    if input == "quit"
      exit
    end

    if input == @answer # this isn't finished; it doesn't increment @bad_count
      return win        # or call bad_guess.
    end

    until (input >= "a") && (input <= "z") && (input.length == 1) # while these aren't true / until they are
      puts "Please enter a valid letter."
      return get_guess # make the user give another guess
    end

    if @letters_guessed.include? input # if letter guessed has already been guessed
      puts "You've already guessed that! Pick a new one."
      puts "Don't guess: " + @letters_guessed.join(" ") # Don't guess: a b c
      return get_guess # make user give another guess
    end

    @letters_guessed.push(input)

    puts "You've guessed: " + @letters_guessed.join(" ") # You've guessed: a b c

    return input
  end


  def check_guess(guess)
    unless @answer.include? guess # if answer not include guess, do this
      @bad_count += 1
      bad_guess

    else # if answer include guess, do this
      letters = @answer.length

      index = 0
      letters.times do

        if @answer[index] == guess # if letter at index in @answer == guess
          @good_count += 1
          # put index / letter into display
          # according to our display, index to update is (index * 2) +1
          index_to_update = (index * 2) + 1

          good_guess(index, index_to_update)
        end

        index += 1
      end
    end
  end


  def bad_guess
    if @bad_count == 1
      @third =   "   {0}".colorize(:blue) + "     |      "
    elsif @bad_count == 2
      @fourth =  "  (\\".colorize(:cyan) + "       |      "
    elsif @bad_count == 3
      @fourth =  "  (\\".colorize(:cyan) + " /)".colorize(:magenta) + "    |      "
    elsif @bad_count == 4
      @fourth =  "  (\\".colorize(:cyan) + "~".colorize(:yellow) + "/)".colorize(:magenta) + "    |      "
    elsif @bad_count == 5
      @fifth =   "   (:)".colorize(:red) + "     |      "
    elsif @bad_count == 6
      @sixth =   "  _/".colorize(:green) + "       |      "
    else # @bad_count == 7
      @sixth = "  _/".colorize(:green) + " \\_".colorize(:light_green) + "    |      "
      lose
    end
  end


  def good_guess(answer_letter, display_letter)
    @tenth[display_letter] = @answer[answer_letter]

    if @good_count == @answer.length
      win
    end
  end


  def win
    puts "You win! The word was #{ @answer }."
    @now_playing = false
  end


  def lose
    puts "You lose! The word was #{ @answer }."
    @now_playing = false
  end
end

Hangman.new
