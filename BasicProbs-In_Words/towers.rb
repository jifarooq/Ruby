def towers
  discs = [[3, 2, 1], [], []]
  
  until game_over?(discs)
    print "Here are the towers: "
    p discs
    puts "Which disk do you want to move?"
    from = gets.to_i
    print "Which tower do you want to move it to?"
    to = gets.to_i
    make_move(discs, to, from)
  end
  
  puts "Yay, you won!"
end

def game_over?(discs)
  return true if discs == [[], [3,2,1], []] || discs == [[], [], [3,2,1]]
  false
end

def make_move(discs, to, from)
  if legal_move?(discs, to, from)
    discs[to] << discs[from].pop
  else
    puts "Illegal move. Try again."
  end
end

def legal_move?(discs, to, from)
  return false unless to.between?(0, 2) && from.between?(0, 2)
  return false if discs[from].empty?
  return true if discs[to].empty? || discs[from].last < discs[to].last
  true
end

towers
