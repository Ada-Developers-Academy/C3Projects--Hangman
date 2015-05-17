
require 'colorize'

class Hangman

 

  def initialize
    @user_guesses = []
    @wrong_count = 0
    @word = pick_word 
    puts "Answer: #{@word.join}"
    @underlines = create_underlines
    @ascii =  ["|     _________", 
               "|     |/      |", 
               "|     |",
               "|     |",
               "|     |",
               "|     |",
               "|     |",
              ]

    @man_array =  [
                  "|     |      / \\".colorize(:red),
                  "|     |       |".colorize(:cyan),
                  "|     |      \\|/".colorize(:light_yellow),
                  "|     |      (_)".colorize(:magenta)
                  ]

    play
  end

#Program picks a word for the player.
  def pick_word
    word_options = %w(scared selection shake shaking shallow shout silly simplest slight
                    slip slope soap solar species spin stiff swung tales thumb zoo
                    tobacco toy trap treated tune university vapor vessels wealth wolf)

    word = word_options.sample.split(//)
    return word
  end
#joins the ascii art and the underlines for the letters in the word.
  def ascii_art
    @ascii[7] = @underlines.join
    puts @ascii
  end
#creates the correct amount of underlines for each letter in the word.
  def create_underlines
    underlines = ["| ____|___ word: "]
    @word.length.times do
      underlines.push("_ ")
    end
    return underlines
  end
#adds pieces to the ascii art man each time the user gets answers incorrectly. 
#Does not penalize user for guessing the same letter  
  def add_to_man
    if !@user_guesses.include?(@user_letter.upcase)
      @wrong_count += 1
      index_to_replace_ascii = @wrong_count + 1
      new_ascii_row = @man_array.pop
      @ascii[index_to_replace_ascii] = new_ascii_row
    else
      puts "You already guessed this letter"
    end
  end
#replaces the underlines with correct letters.
  def replace_underlines
    @word.each_with_index do |letter, index|
      if @user_letter == letter
        @underlines[index+1] = @user_letter.upcase + " "
      end
    end
  end
#checks if user won
  def win_check 
    if @underlines.include?("_ ") == false
      ascii_art
      abort("Yay!! You win")
    end
  end
#checks if user ran out of guesses. 
  def lose_check 
    if @wrong_count >= 4
      ascii_art
      abort("You Lose")
    end
  end
#checks if user guess is correct. If incorrect, program adds a piece of the ascii art man.    
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
#Makes sure user input is valid or if user wants to quit. 
  def get_guess
    @user_letter = "0"
    until ("a".."z").include?(@user_letter)
      puts "Please enter a letter:"
      @user_letter = gets.chomp.downcase.strip
      if @user_letter == "quit"
        abort("Come again soon")
      end
    end
  end
#controls game flow.
  def play
    puts "welcome"
    while true
      ascii_art
      puts "You've already guessed: #{@user_guesses.join(" ")}"
      get_guess
      check_guess
    end
  end
end

Hangman.new

