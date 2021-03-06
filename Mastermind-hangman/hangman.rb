class Hangman
  
  def initialize(player1,player2)
    @p1 = player1
    @p2 = player2
    @secret_letters = @p1.pick_word.split("")
    @current_state = Array.new(@secret_letters.count) { "_" }
    @letter_guessed = false
  end

  def add_to_player_guesses(user_input)
    @p2.guess_letter(user_input)
  end

  def display
    puts "\n" + "Secret word: #{ @current_state.join('') }"
  end
  
  def out_of_guesses?
    @p2.tries == 0
  end
  
  def update_current_state(user_input)
    old_state = @current_state.dup

    @secret_letters.each_with_index do |letter, index|
      if letter == user_input
        @current_state[index] = letter
      end
    end

    @letter_guessed = (old_state == @current_state ? false : true)
  end
  
  def play
    puts "Welcome to Hangman!"
    
    until game_over?
      display
      guess = @p2.get_user_input
      update_current_state(guess)
      add_to_player_guesses(guess)
      @p2.count_down_tries unless @letter_guessed
    end
    
    print_outcome
  end

  def print_outcome
    if out_of_guesses? 
      (puts "You lose, you're out of guesses, the answer was #{ @secret_letters.join("") }")
    else
      (puts "Congrats, you've solved the word \"#{ @secret_letters.join('') }\" in #{@p2.guesses.size} guesses")
    end
  end
  
  private
    
    def game_over?
      @current_state == @secret_letters || out_of_guesses?
    end
  
end

class Player
  attr_reader :name, :word, :guesses, :tries
  
  def initialize(name = "computer")
    @name = name
    @word = nil
    @guesses = []
    @tries = 10
    @dictionary = load_dictionary
  end
  
  def count_down_tries
    @tries -= 1
  end
  
  def get_user_input
    loop do
      puts "Guess a letter.  You have #{@tries} tries left."
      user_input = gets.chomp.downcase
      return user_input if okay_letter?(user_input)
      puts "Invalid letter #{user_input}.  Try again."
    end
  end
  
  def pick_word
    puts "What is the length of the word?"
    word_length = gets.chomp.to_i
    @word = @dictionary.select{ |word| word.length == word_length }.sample
  end
  
  def guess_letter(letter)
    @guesses << letter
  end
  
  def valid_input?(user_input)
    user_input.match(/[a-z]{1}/) && user_input.length == 1
  end

  def okay_letter?(user_input)
    return true if valid_input?(user_input) && !self.guesses.include?(user_input)
    nil
  end
  
  def load_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end
  
end

class HumanPlayer < Player
end

class CompPlayer < Player

  def pick_word
    @dictionary.sample
  end
  
  def get_user_input
    alphabet = [*'a'..'z']
    loop do
      choice = alphabet.sample
      p choice
      return choice unless @guesses.include?(choice)
    end
  end
  
end


justin = HumanPlayer.new("Justin")
comp = CompPlayer.new
test = Hangman.new(comp, justin)
test.play