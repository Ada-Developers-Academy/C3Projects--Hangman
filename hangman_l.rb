require "colorize"

class Hangman

  def initialize
    @word_choices = ["cheeseburger", "cat", "dog", "whatever", "mississippi", "octothorpe", "splat", "bang"]
    @answer = populate_answer
    @wrong_counter = 0
    @wrong_answers = []
    @blank_answer_row = "_ " * @answer.length
    @answer_output = @blank_answer_row.split(' ')

  # Comment line below to show/hide answer
    #puts @answer

    puts @blank_answer_row
    user_prompt
  end

  #randomly selects a word from the list
  def populate_answer
    random = @word_choices[rand(0...@word_choices.length)]
    random = random.split(//)
  end

#--------------------------------------------------------
# USER INPUT

# Generates art/prompts for user interface
  def user_prompt
    # Compares user guess with answer
    until @answer == @answer_output
      print_art
      puts "\nPlease enter a letter."
      puts "\nWRONG GUESSES:" + @wrong_answers.join(" ") + "\n"
      puts "YOUR GUESS:"
      @guess = gets.chomp.downcase
      check_user_input

        # if the answer array includes the guess letter
        if @answer.include?(@guess)
          # setting it to replace the spaces in answer_output with the correctly guessed letters
          @answer.each_index do |x|
            if @answer[x] == @guess
              @answer_output[x] = @guess
            end
          end

        else
          #keeping track of wrong guesses
          @wrong_counter += 1
          @wrong_answers.push(@guess)
        end
        #displaying wrong guesses to user
        puts @answer_output.join(" ")

    end
    # win condition
    puts "CONGRATULATIONS! YOU WIN!"
  end

  def check_user_input
    #searching for alphabetical input and accounting for the edgecase of "0"
    while @guess.length > 1 || @guess.to_i != 0 || @guess == "0"

      puts "Please enter a valid character."
      @guess = gets.chomp.downcase

    end

  end

# Generates ascii dragon art
  def print_art
    if @wrong_counter == 0
      puts "
                ._____.
              .          .
            :              :
           ;                ;
           |                |
           |                |
           ;                ;
            :              /
    ---------.           .---------
                ;.____.;
    ".colorize(:green)

    elsif @wrong_counter == 1
      puts "
                ._____.
              .          .
            :              :
           ;       ^        ;
           |       |        |
           |             ^  |
           ;    |        |  ;
            :  \\       /  /
    ---------.  |      | .---------
                ;.____.;
    ".colorize(:light_black)

    elsif @wrong_counter == 2
      puts "
                .__^__.
              .           .
            :    /         :
           ;       ^    /   ;
           |   *   |        |
           |    *        ^  |
           ;    |        |  ;
            :  \\       /  /
    ---------.  |      | .---------
                ;.____.;
    ".colorize(:white)

    elsif @wrong_counter == 3
      puts "
                   (\\^~^/)
                    )d b(
                  \\(  _  )/
                   ((q_p))
                . _________ .
              :    /         :
             ;       ^    /   ;
             |   *   |        |
             |    *        ^  |
             ;    |        |  ;
              :  \\       /  /
      ---------.  |      | .---------
    ".colorize(:yellow)
    elsif @wrong_counter == 4
      puts "
                 (\\^~^/)
          ._____  )d b(  _____.
         .__)_   \(  _  )/  _(__.
         ._)_    ((q_p))    _(_.
           \\__  .-)\\u/(-.  __/
            \\ :\\,-.   .   ,-./
             |||\\,       ,/||
             | \\    /\\   /  |
             ;    \\ -<      ;
              :   \\ -. \\_  /
      ---------. \\       .---------
                 ;.____.;
    ".colorize(:magenta)
    elsif @wrong_counter == 5
      puts "
           (\\               /)
          __)\\             /(__
         __)_ \\  (\\!~!/)  / _(__
        __)_ `.\\  )d b(  /.' _(__  *YOU'RE NOT MY MOMMY*
      ___)_ `. \\\\(  _  )// .' _(___  *BREATHES FIRE*
       )_  `. \\  ((q_p))  / .'  _(_    *GAME OVER*
       _)`.  \\  ,-)\\_/(-.  /  .'(_
        _) ,-._/v/vvvvv\\v\\_,-. (_
        _)///(._/v(___)v\\_.)\\\\\\(_
         \\_ ___/v(_____)v\\___ _/
           /vvv\\(_______)/vvv\\
           \\vvv/v(_____)v\\vvv/
           _\\vv\\\\v(___)v//vv/_
          '>_`  \\`-._.-'/  '_<`
          ' >_,-'       `-._<`

      ".colorize(:red)
      exit

    end
  end


end

Hangman.new
