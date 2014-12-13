MAX_TRIES = 15 

class Hangman
  
  def initialize(player1, player2)
    @picking_player = player1
    @guessing_player = player2
    @guessing_player.set_word_length( @picking_player.pick_word )
  end
  
  def add_to_player_guesses(user_input)
    @guessing_player.push_guesses(user_input) 
  end
  
  def display
    puts "Secret word: #{ @guessing_player.game_state.join('') }"
  end
  
  def game_over?
    !@guessing_player.tries_left? || @guessing_player.solved?
  end
  
  def play
    puts "Welcome to Hangman!"
    
    until game_over?
      display
      choice = @guessing_player.get_user_input
      add_to_player_guesses(choice)
      @picking_player.check_letter_and_position( choice, @guessing_player)
      @guessing_player.update_game_state(@guessing_player)
    end
    
    if @guessing_player.solved? 
      (puts "Congrats #{ @guessing_player.name }! You've solved the word in #{MAX_TRIES-@guessing_player.tries} guesses") 
    else 
      (puts "#{ @guessing_player.name }, you're out of guesses.  You lose.") 
    end
  end
  
end

class Player
  attr_reader :name, :game_state, :guesses, :tries, :word
  attr_accessor :correct_letters
  
  def initialize(name = "computer")
    @name = name
    @guesses = []
    @tries = MAX_TRIES
    @correct_letters = {}
  end
  
  def count_down_tries
    @tries -= 1
  end
  
  def push_guesses(letter)
    @guesses << letter
  end
  
  def set_initial_game_state(word_length)
    @game_state = Array.new(word_length) { "_" }
  end
  
  def solved?
    !@game_state.include?("_")
  end
  
  def tries_left?
    @tries > 0
  end
  
  def update_game_state(player)
    player.correct_letters.each do |key, values|
      values.each do |index|
        player.game_state[index] = key
      end
    end
  end
  
end

class HumanPlayer < Player
  def get_user_input
    loop do
      puts "Guess a letter.  You have #{@tries} tries left."
      user_input = gets.chomp.downcase
      return user_input if okay_letter?(user_input)
      puts "Invalid letter #{user_input}.  Try again."
    end
  end
  
  def check_letter_and_position(letter, player)
    puts "Is #{letter} in your word? #{player.tries} tries left"
    player.count_down_tries
    selection = gets.chomp.downcase
    if selection[0] == 'y'
      puts "Where are the positions"
      selection2 = gets.chomp.split(',').map(&:to_i)
      player.correct_letters[letter] = selection2
    end
  end
  
  def pick_word
    puts "What is the length of the word?"
    word_length = gets.chomp.to_i
  end
  
  private 
  
    def valid_input?(user_input)
    user_input.match(/[a-z]{1}/) && user_input.length == 1
  end

    def okay_letter?(user_input)
    return true if valid_input?(user_input) && !self.guesses.include?(user_input)
    nil
  end
end

class CompPlayer < Player

  def initialize 
    super
    @dictionary = load_dictionary
    @word = pick_random_word_from_dictionary
  end
  
  def filter_number_of_words(word_length)
    @smart_dictionary = @dictionary.select{|word| word.length == word_length }
  end
  
  def check_letter_and_position(letter, player)
    player.count_down_tries
    indices = []
    
    @word.split("").each_with_index do |char, index|
        indices << index if char == letter
    end
    player.correct_letters[letter] = indices
  end
  
  def get_user_input
    update_smart_dict_by_pos
    update_smart_dict_by_letters
    most_frequent_letter
  end
  
  def load_dictionary
    File.readlines("dictionary.txt").map(&:chomp)
  end
  
  def pick_random_word_from_dictionary
    @dictionary.sample
  end
  
  def most_frequent_letter
    long_string = @smart_dictionary.join('')
    counts = Hash.new(0)
    long_string.split("").each do |char|
      counts[char] += 1 unless @guesses.include?(char)
    end
    counts.max_by { |k, v| v }.first
  end
  
  def pick_word     #is this needed?
    @word.length
  end 
  
  def set_initial_game_state(word_length)
    @game_state = Array.new(word_length) { "_" }
    filter_number_of_words(word_length)
  end

  def update_smart_dict_by_pos
    dummy_copy = @smart_dictionary.dup
    @smart_dictionary.each do |word| 
      temp_arr = word.split('')
      
      @game_state.each_with_index do |char, index|
        dummy_copy.delete(word) unless char == "_" || temp_arr[index] == char
      end
    end
    @smart_dictionary = dummy_copy.dup
  end
  
  def update_smart_dict_by_letters
    dummy_copy = @smart_dictionary.dup
    wrong_guesses = @guesses - @game_state
    @smart_dictionary.reject! do |word|
      wrong_guesses.each do |char|
        dummy_copy.delete(word) if word.include?(char)
      end
    end
    @smart_dictionary = dummy_copy.dup
  end
  
end


auster = HumanPlayer.new("Auster")
justin = HumanPlayer.new("Justin")
comp = CompPlayer.new
comp2 = CompPlayer.new('computer2')
test = Hangman.new(justin, comp)
test.play