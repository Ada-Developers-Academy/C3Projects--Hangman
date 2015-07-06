# Hangman
require "colorize" # Colorize gem implementation used to change the different pieces of
                   # the ship different colors in accordance with wrong guesses.     

class Hangman       # Creation of class, always capitalized 
  
  # (def(create method) initiate ) 
  # m: " Hey Universe , I want to create a program (cake) called Hangman.(Thus the capital "H" above.)
  # Universe: okay. cool, m. What do you want in this program. What variables (ingredients) 
  #           do you need to make this program (recipe)???
  # m: " well, I know for sure I'll need an answer, an answer line, and I need to keep track 
  #     of wrong guesses. I'm gonna create a method for how to start the game. could you keep 
  #      track of that as well?"
  # Universe: cool. put an at (@) in front of those variables initially, just so I know to be on 
  #           the lookout for those; 
  #           so I can "instantiate"/ thunderbolt, lightning, zap/create those for you.
  # m: "thanks, Lady!"
  # Universe: No problem, my love. 
  #           Remember though, you're gonna need to give those names when you ask for them initially.
  #           So we're in the same loop.
  # m: "U got jokes!"" *smirk emoji*
  # Universe: Girl, always.   



  def initialize     
    # Answer which will be pulled from random list of 10 words
    @answer = populate_answer
    # Display
    @answer_line = answer_line
    # count of wrong answers
    @wrong_count = 0
    start
  end

  def start   # opening screen: puts greeting, full Enterprise visible in default terminal color.
    puts "Welcome to Star Trek Hangman! Good luck!"
    # Keeps track of game play
    @now_playing = true  

    draw_board
    answer_line
    # play
    get_guess
  end

# ------------------
# Create answer

# m: "U, this is the method to create @answer." 
# U:  yup, yup.
# m:" here are the answers for the game. I put them in an array, U. That way, you have an assigned
#     value for each one. Please populate the answer by shuffling the array then pop the last word out 
#     after you shuffle the array. I'm gonna use that word as the "answer" each time. "return" means 
#     give it back to me after you shuffle.pop"
# U:  Word. got it.


  def populate_answer           
    answer_array = ["PICARD", "GUINAN", "WORF", "WARP", "ENGAGE", "ENTERPRISE", "DATA", "ROMULAN", "VULCAN", "BETAZOID", "KLINGON"]

    answer = answer_array.shuffle.pop
    return answer
  end

# ------------------
# Visual methods
# m: "U, here's the method to draw_board, which I asked for earlier in the start method definition."
# U: sweet. Hmmm, looks a little complicated. Explain.
# m: " no prob, girl.
#    "1st - instead of that traditional "hangman" figure which reminds me of the violent
#            history against part of our human race because of ignorance and profit, let's 
#            use the Star Trek Enterprise as it symbolizes well, you know the prime directive,etc..."
#    "2nd -  let's start with the whole ship. As long as the user guesses right, the ship stays whole."
#    "3rd -  when they guess wrong though, take a part of the ship away, and turn it the color
#            listed after the dot."
# U: gotcha.
# m: "Also, about the three quotes. I'm using that to ask you to keep the ship drawing together, double
# quotes around single quotes. Also, I put an additional backslash in front of backslashes in the
# ASC II drawing. This "escapes" them, so the drawing displays correctly and doesn't skew."
#
  def draw_board
    if @wrong_count == 0
      puts """
    ___________________          _-_
    \\==============_=_/ ____.---'---`---.____
                \\_ \\    \\----._________.----/
                  \\ \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

"""
    elsif @wrong_count == 1
      puts """
                                  _-_
                         ____.---'---`---.____
                \\_ \\    \\----._________.----/
                  \\ \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

""".cyan
    elsif @wrong_count == 2
      puts """
                                  _-_
                         ____.---'---`---.____
                    \\    \\----._________.----/
                     \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

      """.blue
    elsif @wrong_count == 3
      puts """
                                  _-_
                         ____.---'---`---.____
                          \\----._________.----/
                          /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

      """.yellow
    elsif @wrong_count == 4
      puts """
                                  _-_
                         ____.---'---`---.____
                          \\----._________.----/
                          /  /    `-_-'





      """.magenta
    elsif @wrong_count == 5
      puts """
                                  _-_
                         ____.---'---`---.____
                          \\----._________.----/
                                  `-_-'





      """.red
    else
      puts "Sorry,WARP CORE BREACH! You lose!".red.blink
      exit
    end

  end

# m: " Here's the method definition for @answer_line - It is equal to an empty array.
#    When you shuffle.pop the "answer" out, create a line of empty underscores exactly the same
#    length as the "answer." Put all the underscores in the @answer_line array together as a string
#    - that's what ".join" means. "return" that after you create it, so I (and the user) can see it.
# U: Word.

  def answer_line
    @answer_line = []
    (@answer.length).times do |ans|
      @answer_line.push(" _ ")
    end
    puts @answer_line.join
    return @answer_line
  end


# ------------------
# Check answer

# m: "U, girl. Here's the method definition for get_guess. This is how I think it would be easiest for you
#      to return an answer to the user..."
# U: Aiite, go.
# m: " Okay,
#     1st - until that answer line equals the answer from shuffle.pop: draw the board, and keep
#           displaying the answer line so they'll know how awesome they're doing. Politely ask
#           for a letter while those conditions are true as well.  
#     2nd - If someone/thing tries to give you more than one letter, scold them!
#     3rd - When the user gives you a letter as a guess, evaluate that input against @answer.
#           That's an array though, so you'll have to .split the empty spaces from the input 
#           to make sure it looks exactly like the letters of the chosen @answer.
#     4th - accept the input letter(s) in lower or uppercase; but since all the answers are written in upper-
#           case, turn the user input into uppercase before you evaluate it against the @answer."
#     Still with me?
#  U: yup.
#  m: "awesome, let me break down this conditional loop for you below."
 


  def get_guess

    until @answer_line.join == @answer

      puts "Guess a letter, please:"
      input = gets.chomp.upcase

      while input.length != 1
        puts "You're better than this. Please enter ONE letter, thanks."
        input = gets.chomp.upcase
      end

      letters = @answer.split("")
      # puts letters

#  m: " Now some additional conditions. With ALLLL that information (lines 183 - 191):

      if letters.include?(input)            # does the input match the "letters" ["include?"]
        letters.each do |letter|            # if so, take each letter that fits the condition [ "||" ]
          if letters.include?(input)
            position = letters.index(input) # let's define position as the index spot in the  
            letters[position] = "@"         # @answer array. in that spot where input letter(s)
            @answer_line[position] = input  # match the @answer array,  put an "@." This is a temporary
          end                               # placeholder in the @answer array so that no letters shift
        end                                 # or change location. Now match that input (letter(s)) to the
      else                                  # same position in the @answer_line array." 
       

        @wrong_count += 1                   # m: "U, everytime they guess wrong, add 1."
      end

      draw_board                            # m: "Right or wrong guess, draw the board that            
      puts @answer_line.join                # corresponds with @wrong_count, and display 
    end                                     # @answer_line as a string"

# m: "Universe, when they win, that is when @answer_line.join == @answer, put the following:

      puts "YOU WIN!!! The Federation thanks you!!!".red.blink    
      puts """                                                   
    ___________________          _-_
    \\==============_=_/ ____.---'---`---.____
                \\_ \\    \\----._________.----/
                  \\ \\   /  /    `-_-'
              __,--`.`-'..'-_
             /____          ||
                  `--.____,-'

    """.green.blink

  end

end



Hangman.new             # m: "U, I'm "calling new" on the class you created so that when you
                        # create and run this new class in Ruby, it will instantly exist with
                        # all the given variables. ".new "completes" the definition of the class,
                        # allowing it to be run directly in terminal instead of irb or pry.   








