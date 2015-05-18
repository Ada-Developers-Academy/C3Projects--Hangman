require "colorize"

class Hangman

  def initialize
    @wrong_count = 0
    @ascii = [
      "|     _________".light_black,
      "|     |/      |".light_black,
      "|     |".light_black,
      "|     |".light_black,
      "|     |".light_black,
      "|     |".light_black,
      "|     |".light_black
      ]
     @man_array = [
      "|     |      / \\".colorize(:red),
      "|     |       |".colorize(:cyan),
      "|     |      \\|/".colorize(:yellow),
      "|     |      (_)".colorize(:magenta)
    ]
    @user_guesses = []

    @word = pick_word
    @underlines = create_underlines
    puts "Answer: #{@word.join.upcase}" ##TODO: Remove this before it goes to the user.

    @play_status = true
    play
  end

  def pick_word
    word_options = %w(scared selection shake shaking shallow shout silly simplest slight slip slope soap solar species spin stiff swung tales thumb tobacco toy trap treated tune university vapor vessels wealth wolf zoo)
    word = word_options.sample.split(//)
    return word
  end

  def create_underlines
    underlines = ["| ____|___ word: ".light_black]
    @word.length.times do
      underlines.push("_ ")
    end

    return underlines
  end

  def ascii_art
    @ascii[7] = @underlines.join
    puts @ascii
  end

  def play
    puts "Welcome! Let's play Hangman!".cyan
    while true
      ascii_art

      puts "You already guessed: #{@user_guesses.join(" ")}"

      get_guess
      check_guess
    end
  end

  def get_guess
    @user_letter = "0"
    while !("a".."z").include?(@user_letter)
      puts "Please enter a letter:"
      @user_letter = gets.chomp.downcase.strip
      if @user_letter == "quit"
        abort("Goodbye! Please come again!")
      end
    end
  end

  def check_guess
    if @word.include?(@user_letter) == true
      replace_underlines
      win_check
    else
      add_to_man
      lose_check
    end
    @user_guesses.push(@user_letter.upcase)
    @user_guesses.uniq!
  end

  def add_to_man
    if !@user_guesses.include?(@user_letter.upcase)
      @wrong_count += 1 ## at 4 wrongs, the user loses

      # Update the ascii art to include the new part of the man
      index_to_replace_ascii = @wrong_count + 1
      new_ascii_row = @man_array.pop
      @ascii[index_to_replace_ascii] = new_ascii_row
    else
      puts "You already guessed that letter! Try again.".colorize(:light_red)
    end
  end

  def replace_underlines
    @word.each_with_index do |letter, index|
      if letter == @user_letter
        @underlines[index+1] = @user_letter.upcase + " "
      end
    end
  end

  def win_check
    if @underlines.include?("_ ") == false
      ascii_art
      abort("YAY!!! YOU WIN!!".colorize(:light_cyan))
    end
  end

  def lose_check
    if @wrong_count == 4
      ascii_art
      abort("YOU LOSE!".colorize(:light_red))
    end
  end

end

Hangman.new
