require "colorize"

class Hangman
    def initialize

      @answer_bank = ["cupcake", "spaghetti", "cookie", "hamburger", "pizza", "sandwich", "crackers", "salad","cheese", "burrito"]
      @guesses = 4
      @num_correct = 0
      @current_answer = @answer_bank[rand(@answer_bank.length)]
      @current_answer_array = @current_answer.split(//)
      @fillable_answer = []
      @alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K","L", "M", "N", "O", "P", "Q", "R", "S",
      "T", "U", "V", "W", "X", "Y", "Z"]
      @already_guessed =[]
      @current_answer_array.length.times do |x|
        @fillable_answer[x]= " _ "
      end


      draw_art
      print_word
      play

    end

    def draw_art


      art = <<-END
|     _________
|     |/      |
|     |
|     |
|     |
|     |
|     |
|_____|___________

  END

    if @guesses == 3
      head = "(_)".colorize(:red)
      art = <<-END

      |     _________
      |     |/      |
      |     |      #{head} "I would wave for help but I don't have arms."
      |     |
      |     |
      |     |
      |     |
      |_____|___________

        END

      elsif @guesses == 2
        head = "(_)".colorize(:red)
        arms = "\\|/".colorize(:white)
        art = <<-END

        |     _________
        |     |/      |
        |     |      #{head} "Is it getting hot in here? Anyone?"
        |     |      #{arms}
        |     |
        |     |
        |     |
        |_____|___________

          END

        elsif @guesses == 1
          head = "(_)".colorize(:red)
          arms = "\\|/".colorize(:white)
          torso = "|".colorize(:blue)
          art = <<-END

          |     _________
          |     |/      |
          |     |      #{head} "Lietuenent Dan: I can't feel my legs!"
          |     |      #{arms}
          |     |       #{torso}
          |     |
          |     |
          |_____|___________

            END

          elsif @guesses == 0
            head = "(_)".colorize(:red)
            arms = "\\|/".colorize(:white)
            torso = "|".colorize(:blue)
            legs =  "/ \\".colorize(:magenta)
          art = <<-END
          |     _________
          |     |/      |
          |     |      #{head} "Dead men tell no tales!"
          |     |      #{arms}
          |     |       #{torso}
          |     |      #{legs}
          |_____|___________

            END

          end

          puts art
    puts @current_answer
    #drawing hangman
    end

    def print_word
      print "WORD: "


      puts @fillable_answer.join
      puts ""
      puts "Letters Guessed: #{@already_guessed.join(" ")}"
      puts "Incorrect Guesses Left: #{@guesses}"
      puts ""
    end

    def play
      while @guesses > 0
        puts "Type a letter or word"
        letter = gets.chomp.downcase

        wrong = true
        if letter.length == 1
        until @alphabet.include?(letter.upcase)
        puts "You must put an actual letter or word please"
        puts "Type a letter or word"
        letter = gets.chomp.downcase
      end

        @current_answer_array.length.times do |x|
          if @current_answer_array[x] == letter
            @fillable_answer[x]= " #{letter} "
            wrong = false
              unless @already_guessed.include?(letter)
            @num_correct = @num_correct + 1
              end
          end


          end
        @already_guessed.push(letter)

      if wrong == true
        @guesses = @guesses - 1
      end

      elsif @current_answer == letter
        puts <<-END
        |     _________
        |     |/
        |     |  "Hooray! You have saved me
        |     |           from losing my head!"
        |     |      (_)
        |     |      \\|/
        |     |       |
        |     |      / \\
        |_____|___________
        END
      exit

        else
          @guesses = @guesses -1
        end


        draw_art
        print_word
        #Check for winning before moving on or taking away guesses
        if @num_correct == @current_answer.length
          puts <<-END
          |     _________
          |     |/
          |     |  "Hooray! You have saved me
          |     |           from losing my head!"
          |     |      (_)
          |     |      \\|/
          |     |       |
          |     |      / \\
          |_____|___________
          END

          exit
        end

      end

      puts "You need to learn how to spell, you killed me!"
      puts "The word was #{@current_answer}."
      puts ""
      exit
    end

end

Hangman.new
