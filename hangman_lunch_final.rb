require "colorize"
class Hangman #

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

    start
  end

  def display_board
    @hangman = [@first, @second, @third, @fourth, @fifth, @sixth, @seventh, @eighth, @ninth, @tenth]
    @hangman.each do |line|
      puts line
    end
    puts "\n"
  end

  def set_answer
    possible_answers = ["potato", "broccoli", "animal", "hotdog",
    "elephant", "cat", "taco", "whale", "walrus", "vulture"]
    # select random word from possible anaswer
    which_random_index = rand(0...possible_answers.length)
    @answer = possible_answers[which_random_index]

    # updates hangman word display with dashes equal to the length of the word
    @tenth  = " _" * @answer.length #18 characters

  end

  def start
    puts "Let's play hangman"
    @good_count = 0
    @bad_count = 0
    @now_playing = true
    @letters_guessed = []
    set_answer # at the start of the game, it shows the number of letters the word contains
    display_board # displays our board
    play
  end

  def play
    while @now_playing == true
      guess = get_guess
      check_guess(guess)
      display_board
    end
  end

  def get_guess
    puts "Guess your letter."
    input = gets.chomp.downcase #downcase = shouldn't matter if caps

    if input == "quit"
      exit
    end

    until (input >= "a") && (input <= "z") && (input.length == 1) # while/until they are true
      puts "Please enter a valid letter."
      return get_guess
    end

    if @letters_guessed.include? input # if letters guessed has already been guessed
      puts "You already guessed that. Choose another."
      puts "Don't pick: " + @letters_guessed.join(" ")
      return get_guess # makes user give another guess
    end

    @letters_guessed.push(input) # displays the letters I've already guessed
    puts "You've guessed: " + @letters_guessed.join(" ")
    return input
  end

  def check_guess(guess)
    unless @answer.include? guess # checks to see if the guess is correct
      @bad_count += 1
      bad_guess

    else #
      letters = @answer.length
      index = 0

      letters.times do
        if @answer[index] == guess #if letter at index in answer = guess

          @good_count += 1 # puts index/letter into display
          # according to our display, index to update is (index * 2) + 1
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
      @fourth =  "  (\\".colorize(:cyan) + " /)".colorize(:magenta) + "    |        "
    elsif @bad_count == 4
      @fourth =  "  (\\".colorize(:cyan) + "~".colorize(:yellow) + "/)".colorize(:magenta) + "    |      "
    elsif @bad_count == 5
      @fifth =   "   (:)".colorize(:red) + "     |      "
    elsif @bad_count == 6
      @sixth =   "  _/".colorize(:green) + "       |      "
    else #@count == 7
      @sixth =   "  _/".colorize(:green) + " \\_".colorize(:light_black) + "    |      "
      lose
    end
  end

  def good_guess(answer_letter, display_letter)
    @tenth[display_letter] = @answer[answer_letter]

    if @good_count == @answer.length #
      win
    end
  end

  def win
    puts "You win"
    @now_playing = false

  end

  def lose
    puts "You lose"
    @now_playing = false
  end

end

Hangman.new
