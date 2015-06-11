
class Hangman
	def initialize

		# Library of words
		@words = ["orca", "cheese", "cake", "pumpkin", "sun", "apple", "cloud", "paint", "bird", "travel", "lollipop", "ada"]

		@answer_word = choose_word # chooses answer (array of characters)
		@answer_copy = @answer_word.dup # creates arrage of correct length for @word_display
		@word_display = @answer_copy.fill("_")
		@letters_guessed = []

		@default_guesses = 7
		@wrong_count = 0

		start
	end

	def start
		@keep_playing = true
		puts "Let's play HANGMAN!"

		update_visuals
		play
	end

	def play
		# Checks for win or lose
		while @keep_playing == true
			if @wrong_count < 7 && win != true
				puts "Guess one letter and then hit enter. Type \"quit\" if you don't want to play."
				print "YOUR GUESS: "
				@current_guess = get_guess # gets guess from user
				check_guess(@current_guess) # result of checked guess and updates number of wrong gueses
			elsif win == true
				puts "You win! The word was #{@word}! Congrats :)"
				@keep_playing = false
			else
				@keep_playing = false
				puts "Sorry, you lose. The word was #{@word}."
				exit
			end
		end
	end

	# get_guess is called in play method
	def get_guess
		guess = gets.chomp.downcase.delete(" ")

		if guess == "quit"
			exit
		end

		# guess is string
		return guess
	end

	# check_guess is called in play method
	def check_guess(guess)

		if @answer_word.include?(guess) # Correct guess

			@answer_word.each_index do |index| # Checks and replaces correct guesses
		 		if @answer_word[index] == guess
		 			@word_display.delete_at(index)
					@word_display.insert(index, guess)
				end
			end

			puts "Yay! You guessed a correct letter."

		else # Incorrect guess
			puts "Wrong guess, try again! :("
			@wrong_count += 1
			puts "Guesses left: #{@default_guesses - @wrong_count}"
		end

		@letters_guessed.push(guess)
		update_visuals
	end


	# ANSWER METHODS ---------------------------------------------------------------

	# Chooses the answer from the library
	def choose_word
	 	# chooses random word from library
	 	@word = @words[rand(0...12)]
	 	# creates array of letters from word
	 	word_array = @word.split(//)
		return word_array
 	end

	# Checks the guessed word against the answer
	def win
		@answer_word == @word_display
	end


	# VISUAL METHODS ---------------------------------------------------------------

	def update_visuals
		# Prints body and words
		puts body
		puts @word_display.join
		puts "Letters guessed: #{@letters_guessed.join(", ")}"
	end

	def body
		@top = "      _________    "
		@top_post = "      |/      |    "
		@pipe_head = "      |      (_)"
		@pipe_body_1 =  "      |       |"
		@pipe_left_arm_body =  "      |      \\|"
		@pipe_left_arm_body_right_arm =  "      |      \\|/"
		@pipe_body_2 = "      |       |"
		@pipe_left_leg = "      |      /"
		@pipe_left_leg_right_leg = "      |      / \\"
		@pipe = "      |		"
		@bottom = "  ____|___"

		if @wrong_count == 0
			@body_array = [@top, @top_post, @pipe, @pipe, @pipe, @pipe, @pipe, @bottom]
		elsif @wrong_count == 1
			update_body_array(2, @pipe_head)
		elsif @wrong_count == 2
			update_body_array(3, @pipe_body_1)
		elsif @wrong_count == 3
			update_body_array(3, @pipe_left_arm_body)
		elsif @wrong_count == 4
			update_body_array(3, @pipe_left_arm_body_right_arm)
		elsif @wrong_count == 5
			update_body_array(4, @pipe_body_2)
		elsif @wrong_count == 6
			update_body_array(5, @pipe_left_leg)
		elsif @wrong_count == 7
			update_body_array(5, @pipe_left_leg_right_leg)
		end
	end

	# Used in body method to add body pieces to ascii art
	def update_body_array(index, body_piece)
		@body_array[index] = body_piece
		puts @body_array
	end

	Hangman.new

end
