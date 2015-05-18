# Elsa's hangman (partnered with Carly)
# Due: 150515
# Breakfast


class Hangman

  def initialize
    @now_playing = true # presently useless becuase win/lose executions simply use 'exit', but would have been nice for prompting user to play again in a loop
    @wrong_count = 0 # tracks incorrect letter guesses

    # board
    @row1 = "|     _________"
    @row2 = "|     |/      |"
    @row3 = "|     |      "
    @row4 = "|     |      "
    @row5 = "|     |       "
    @row6 = "|     |      "
    @row7 = "|     |"
    @row8 = "| ____|___"

    @board = [@row1, @row2, @row3, @row4, @row5, @row6, @row7, @row8]

    @dictionary = ["hotdog", "elephant", "computer", "developer", "baby", "dragon", "classmate", "program", "teamwork", "fun"]

    start

  end


  # Setup
  def start
    puts "Let's play hangman!"
    puts @board
    pick_word
    # shows blank letter slots for word to be guessed
    @word = ["_ "] * @answer_letters.length
    puts @word.join
    play
  end


  def play
    while @now_playing == true
      get_guess
      check_guess
      puts @board
      puts @word.join
      win?
    end
  end


  def pick_word
    # randomly selects word
    answer = @dictionary[rand(0...@dictionary.length)]
    # converts word to array letters
    @answer_letters = answer.split(//)
    # puts "(word is: " + "#{@answer_letters.join})" # used in testing
  end


  # User Guess
  def get_guess
    puts "Guess a letter! (or type \"quit\" to stop)"
    input = gets.chomp.downcase

    if input == "quit"
      puts "Bye!"
      exit
    end

    # converts user guess into array of letters
    # currently only accepts fist letter, but would have been nice for future 'guess a whole word' implementation
    # didn't have time to validate against edge cases like empty strings, numbers and special characters
    @guess_letters = input.split(//)
    puts "\nYou guessed: " + "#{@guess_letters[0]}".upcase

  end


  # Guess Validation
  def check_guess
    # compares user's letter guess to all letters in word
    @answer_letters.length.times do |index|
      if @answer_letters[index] == @guess_letters[0]
        # if correct, puts the letter in all slots in word display
        @word[index] = "#{@guess_letters[0]} ".upcase
      end
    end
    # intended for this to be an elsif above, but couldn't get the hangman parts to get redrawn while inside the iterator
    if !(@answer_letters[(0...@answer_letters.length)].include?(@guess_letters[0])) # super ugly but it worked in a time crunch to finish
      @wrong_count += 1
      draw_man
      return @wrong_count
    end
  end

  # adds hangman parts by replacing board rows depending on number of incorrect guesses
  def draw_man
    if @wrong_count == 1
      @board[2] = "|     |      (_)"
    elsif @wrong_count == 2
      @board[3] = "|     |       | "
    elsif @wrong_count == 3
      @board[3] = "|     |      \\| "
    elsif @wrong_count == 4
      @board[3] = "|     |      \\|/"
    elsif @wrong_count == 5
      @board[4] = "|     |       |"
    elsif @wrong_count == 6
      @board[5] = "|     |      /  "
    elsif @wrong_count >= 7
      @board[5] = "|     |      / \\"

      puts @board # ensures last leg will get drawn
      puts @word.join
      puts "\nYou lose!"
      @now_playing = false
      exit
    end
  end


  # Win Condition
  def win?
    # win when no more letters are left blank
    @word.each do |index|
      if !(@word.include?("_ "))
      puts "\nYou won!"
      @now_playing = false
      exit
      end
    end

  end


end # end hangman class

Hangman.new
