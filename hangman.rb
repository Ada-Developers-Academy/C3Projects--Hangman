require 'colorize'

WORDS = %w(method index bracket braces gem git terminal length
        count push class hash comment colorize mastermind orange
        online dragon seattle ada ruby sinatra)

class Hangman
  def initialize
    @word 			= WORDS.sample
    @blank_spaces 	= "_ -" * @word.length
    @blank_array 	= @blank_spaces.split("-")
    @answer_letters = @word.split(//)
    @wrong_answers 	= 0
    @guess_array 	= []

    draw_hangman
    get_guess
  end

  # GET GUESSES ------------------------------------------------------------->
  # Retrieve guess from user and allow them to exit the game by typing quit.
  # Guesses are pushed to an array.
  def get_guess
    puts "To exit the game, type 'quit'."
    print "Please type a letter to guess the word above. "
    @guess = gets.chomp.downcase
    @guess_array.push(@guess)
    if @guess == "quit"
      puts "The answer was #{@word}."
      exit
    end
    guess_in_answer
  end

  # WIN / LOSE -------------------------------------------------------------->
  # Check to see if the guess is a letter of the alphabet, if not, a colorized error message will show
  # Check to see if the guess is part of the answer, if so, fills in the guess
  # If guess is not in the answer, hangman is drawn
  def guess_in_answer
    if @guess.index(/[[:alpha:]]/) && !@guess.index(/\d/)
      if @answer_letters.include?(@guess)
        (0...@answer_letters.length).each do |index|
          if @answer_letters[index] == @guess
            @blank_array[index] = @guess
          end
        end
      else
        @wrong_answers += 1
      end
    else
      puts "ERROR".bold.colorize(:red).underline + " That is not a valid response. Please use a letter from 'a' to 'z'".colorize(:yellow)
    end
    draw_hangman
    win?
    get_guess
  end

  def win?
    if @answer_letters.join == @blank_array.join
      puts "You WIN!!!"
      exit
    end
  end

  # DRAW HANGMAN ------------------------------------------------------------>
  # Draws the hangman as the user makes incorrect guesses - body parts are colored
  def show_guess
    puts "word: #{@blank_array.join}"
    puts "letters guessed: #{@guess_array.join(" ").upcase}"
  end

  def draw_hangman
    if @wrong_answers == 0 && @guess == nil
      puts "Let's play Hangman!!!
		Guess the Ada Developers Academy class related term.

		|     _________
		|     |/      |
		|     |      
		|     |      
		|     |      
		|     |      
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 0
      puts "
		|     _________
		|     |/      |
		|     |      
		|     |      
		|     |      
		|     |      
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 1
      puts "
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |      
		|     |      
		|     |      
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 2
      puts "
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |        \e[0;31m|\e[0m
		|     |        \e[0;31m|\e[0m
		|     |      
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 3
      puts "
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m
		|     |        \e[0;31m|\e[0m
		|     |      
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 4
      puts "
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m\e[0;33m/\e[0m
		|     |        \e[0;31m|\e[0m
		|     |      
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 5
      puts "
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m\e[0;33m/\e[0m
		|     |        \e[0;31m|\e[0m
		|     |       \e[0;32m/\e[0m
		|     |
		| ____|___ "
      show_guess

    elsif @wrong_answers == 6
      puts "
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m\e[0;33m/\e[0m
		|     |        \e[0;31m|\e[0m
		|     |       \e[0;32m/\e[0m \e[0;32m\\\e[0m
		|     |      
		|     |
		| ____|___ 

		You LOSE!!! The word was #{@word}."
      show_guess

      exit
    end
  end

end # class

Hangman.new
