def rps(choice)
  choices = ['rock', 'paper', 'scissors']

  unless choices.include?(choice.downcase)
    raise "Invalid input.  You don't know how to play, FAIL." 
  end
  
  comp_choice = choices[rand(choices.size)]
  
  possible_outcomes = {
    ['rock', 'scissors'] => "You win!",
    ['paper', 'rock'] => "You win!",
    ['scissors', 'paper'] => "You win!",
    ['rock', 'rock'] => "Tie game",
    ['paper', 'paper'] => "Tie game",
    ['scissors', 'scissors'] => "Tie game",
    ['scissors', 'rock'] => "You lose :(",
    ['rock', 'paper'] => "You lose :(",
    ['paper', 'scissors'] => "You lose :("
  }
  
 "#{choice}, #{comp_choice}. #{possible_outcomes[[choice, comp_choice]]}"
end