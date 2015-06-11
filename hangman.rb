class Hangman

  def initialize
    @now_playing = true
    @count = 0

    # Board Display
    @row1 = "|     _________"
    @row2 = "|     |/      |"
    @row3 = "|     |      "
    @row4 = "|     |      "
    @row5 = "|     |       "
    @row6 = "|     |      "
    @row7 = "|     |"
    @row8 = "| ____|_____"

    @board = [@row1, @row2, @row3, @row4, @row5, @row6, @row7, @row8]

    @dictionary = ["hotdog", "elephant", "computer", "developer", "baby", "dragon", "classmate", "program", "teamwork", "fun"]

    start
  end

  def start
    puts "Let's play a game of Hangman!"
    puts @board

    pick_word
    @word = ["_ "] * @answer_letters.length
    puts @word.join
    play
  end

  def play
    while @now_playing == true
      get_guess
      check_guess
      puts @board
      puts @word.join
      win
    end
  end

  def pick_word
    #randomly selects word
    answer = @dictionary[rand(0...@dictionary.length)]
    #convert individual letters of word to array
    @answer_letters = answer.split(//)

    puts "WORD IS:" + " #{@answer_letters.join}"
  end

#___________________________________
# GUESS CODE

  def get_guess
    puts "Guess a letter! \nType quit to exit the game."
    input = gets.chomp.downcase

    if input == "quit"
      puts "Bye!"
      exit
    end
    @guess_letters = input.split(//)
    puts "You guessed: " + "#{@guess_letters[0]}".upcase

  end

    def check_guess
    @answer_letters.length.times do |index|
      if @answer_letters[index] == @guess_letters[0]
        @word[index] = "#{@guess_letters[0]} ".upcase
      end
    end
    if !(@answer_letters[(0...@answer_letters.length)].include?(@guess_letters[0]))
      @count += 1
      draw_man
      return @count
    end
  end

  def draw_man
    if @count    == 1
      #reassign row3
      @board[2] = "|     |      (_)"
    elsif @count == 2
      #reassign row4
      @board[3] = "|     |       |"
    elsif @count == 3
      #reassign row4
      @board[3] = "|     |      \\|"
    elsif @count == 4
      #reassign row4
      @board[3] = "|     |      \\|/"
    elsif @count == 5
      #reassign row5
      @board[4] = "|     |       |"
    elsif @count == 6
      #reassign row6
      @board[5] = "|     |      /"
    elsif @count >= 7
      #reassign row6
      @board[5] = "|     |      / \\"
      puts "You lose!"
      @now_playing = false
      exit
    end
  end

#_________________________________
# WIN/LOSE CODE

  def win
    @word.each do |index|
      if !(@word.include?("_ "))
      puts "YOU WON!"
      @now_playing = false
      exit
      end
   end
  end
end # End Hangman class

Hangman.new
