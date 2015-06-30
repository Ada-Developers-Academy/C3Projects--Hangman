#Lila and Corinne

# works through lunch, first req of dinner (not penalizing repeat guesses on same letter)

require "colorize"

class Hangman
	def initialize

		# library
		@words = ["orca", "cheese", "cake", "pumpkin", "sun", "apple", "cloud", "paint", "bird", "travel", "lollipop", "ada"]

		@answer_word = choose_word # array of characters
		@answer_copy = @answer_word.dup
		@word_display = @answer_copy.fill("_ ")
		@guessed_letters = [] # guessed letter array

		@default_guesses = 7
		@wrong_count = 0

		#creates
		start
	end

# Display (art, word)


	def start
		puts "Let's play HANGMAN."
		update_visuals
		@keep_playing = true

		play
	end

	def play
		# checks for loss due to use of all guesses
		while @keep_playing == true
			if @wrong_count < 7 && win != true
				puts "Guess one letter and then hit enter. Type \"quit\" if you don't want to play."
				print "YOUR GUESS: "
				@current_guess = get_guess #gets guess
				check_guess(@current_guess) # result of checked guess and updates number of wrong gueses
			elsif win == true
				puts "You win! Congrats! :)"
				@keep_playing = false
			else
				@keep_playing = false
				puts "Sorry, you lose"
				exit
			end
		end

	end

	def get_guess
		guess = gets.chomp.upcase.delete(" ")

		if guess == "QUIT"
			exit
		end

		# guess is string
		return guess
	end


	def check_guess(guess)

		if @guessed_letters.include?(guess) #checks if letter has already been guessed to not penalize again
			puts "You guessed this letter already. Try again!"
		elsif @answer_word.include?(guess)
			@answer_word.each_index do |index| # Checks and replaces correct guesses
		 		if @answer_word[index] == guess
		 			@word_display.delete_at(index)
					@word_display.insert(index, guess.upcase)
				end
			end
			@guessed_letters.push(guess) #adds letter to guess letter array
			puts "Yay! You guessed a correct letter."
		else
			puts "Wrong guess, try again! :("
			@guessed_letters.push(guess)
			@wrong_count += 1
			puts "Guesses left: #{@default_guesses - @wrong_count}" # make this pretty - prints hangman
		end

		# visual update
		update_visuals
	end


#-----------------
 #answer methods


 def choose_word
 	# chooses random word from library
 	word = @words[rand(0...12)].upcase
 	# creates array of letters from word
 	word_array = word.split(//)
 	#returns word to caller
 	return word_array
 end

def win
	@answer_word == @word_display
end


#-----------------
#Visual methods

def update_visuals
	# hangman
	puts body
	puts @word_display.join
	puts "Guessed letters: #{@guessed_letters.join}"

end

def body
	@top = "      _________    "
	@top_post = "      |/      |    "
	@pipe_head = "      |      (_)".colorize(:red)
	@pipe_body_1 =  "      |       |".colorize(:blue)
	@pipe_left_arm_body =  "      |      \\|".colorize(:green)
	@pipe_left_arm_body_right_arm =  "      |      \\|/".colorize(:green)
	@pipe_body_2 = "      |       |".colorize(:yellow)
	@pipe_left_leg = "      |      /".colorize(:light_blue)
	@pipe_left_leg_right_leg = "      |      / \\".colorize(:light_blue)
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

def update_body_array(index, body_piece)
	@body_array[index] = body_piece
	puts @body_array
end

Hangman.new

end
