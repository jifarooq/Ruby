class OutOfRangeError < StandardError;end

class NumberGame
  
  def initialize
    @number = rand(101)
    @num_guesses = 0
  end
  
  def play
    loop do
      guess = get_number
      @num_guesses += 1
      break if evaluate_number(guess)
    end
    
    puts "You guessed the number! It took you #{@num_guesses} tries."
  end
  
  def get_number
    begin 
      puts "Choose a number from 1 to 100"          
      guess = Integer(gets.chomp)
      raise OutOfRangeError
        .new("Must be between 1 and 100") unless guess.between?(1, 100)
    rescue ArgumentError => error
      puts error
      retry
    rescue OutOfRangeError => error
      puts error
      retry
    end
    
    guess         
  end
  
  def evaluate_number(guess)
    if @number > guess
      puts "You're too low!"
      return false
    elsif @number < guess
      puts "You're too high!"
      return false
    end
    
    true
  end
  
end