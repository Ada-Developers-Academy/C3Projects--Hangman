require 'colorize'

class Hangman
	def initialize
		@words = ["method", "index", "bracket", "braces", "gem", "git", "terminal", "length", "count", "push", "class", "hash", "comment", "colorize", "mastermind", "orange", "online", "dragon", "seattle", "rubric"]
		@word = @words.sample
		@blank_spaces = "_ -" * @word.length
		@blank_array = @blank_spaces.split("-")
		@answer_letters = @word.split(//)
		@wrong_answers = 0
		@guess_array = []
		@alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
		start
	end

	def start
		puts """
		Let's play Hangman!!!
		|     _________
		|     |/      |
		|     |
		|     |
		|     |
		|     |
		|     |
		| ____|___

		word: #{@blank_array.join}
		"""
		get_guess
	end

# GET GUESSES -----------------------------------------------------
	def get_guess
		puts "Please type a letter to guess the word above."
		puts "To exit the game, type 'quit'."
		@guess = gets.chomp.downcase
		@guess_array.push(@guess)
		if @guess == "quit"
			exit
		end
		guess_in_answer
	end

# WIN / LOSE ------------------------------------------------------

	def guess_in_answer
		if @alphabet.include?(@guess)
			if @answer_letters.include?(@guess)
				(0...@answer_letters.length).each do |index|
					if @answer_letters[index] == @guess
						@blank_array[index] = @guess
					end
				end
			else
				@wrong_answers += 1
			end
		else puts "ERROR".bold.colorize(:red).underline + ": That is not a valid response. Please use a letter from 'a' to 'z'".colorize(:red)
		end
		draw_hangman
		win?
		get_guess
	end

	def win?
		if @answer_letters.join == @blank_array.join
			puts "You win!!!"
			exit
		end
	end

# DRAW HANGMAN ----------------------------------------------------

	def draw_hangman
		if @wrong_answers == 0
		puts """
		|     _________
		|     |/      |
		|     |
		|     |
		|     |
		|     |
		|     |
		| ____|___

		word: #{@blank_array.join}
		letters guessed: #{@guess_array.join(" ")}
		"""

		elsif @wrong_answers == 1
		puts """
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |
		|     |
		|     |
		|     |
		| ____|___

		word: #{@blank_array.join}
		letters guessed: #{@guess_array.join(" ")}
		"""

		elsif @wrong_answers == 2
		puts """
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |        \e[0;31m|\e[0m
		|     |        \e[0;31m|\e[0m
		|     |
		|     |
		| ____|___

		word: #{@blank_array.join}
	  letters guessed: #{@guess_array.join(" ")}
		"""

		elsif @wrong_answers == 3
		puts """
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m
		|     |        \e[0;31m|\e[0m
		|     |
		|     |
		| ____|___

		word: #{@blank_array.join}
	  letters guessed: #{@guess_array.join(" ")}
		"""

		elsif @wrong_answers == 4
		puts """
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m\e[0;33m/\e[0m
		|     |        \e[0;31m|\e[0m
		|     |
		|     |
		| ____|___

		word: #{@blank_array.join}
	  letters guessed: #{@guess_array.join(" ")}
		"""

		elsif @wrong_answers == 5
		puts """
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m\e[0;33m/\e[0m
		|     |        \e[0;31m|\e[0m
		|     |       \e[0;32m/\e[0m
		|     |
		| ____|___

		word: #{@blank_array.join}
	  letters guessed: #{@guess_array.join(" ")}
		"""

		elsif @wrong_answers == 6
		puts """
		|     __________
		|     |/       |
		|     |	      \e[1;34m(_)\e[0m
		|     |       \e[0;33m\\\e[0m\e[0;31m|\e[0m\e[0;33m/\e[0m
		|     |        \e[0;31m|\e[0m
		|     |       \e[0;32m/\e[0m \e[0;32m\\\e[0m
		|     |
		|     |
		| ____|___

		You lose!!! The word was #{@word}.
	  letters guessed: #{@guess_array.join(" ")}
		"""
		exit
		end

	end

end

Hangman.new
