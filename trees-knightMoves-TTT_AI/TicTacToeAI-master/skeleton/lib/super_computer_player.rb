require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    comp_node = TicTacToeNode.new(game.board, mark)
    
    #shuffle children so comp plays differently each time
    possible_moves = comp_node.children.shuffle
    
    #search for winning node.  return if found
    win_node = possible_moves.find{ |child| child.winning_node?(mark) }
    return win_node.prev_move_pos if win_node
    
    #search for non-losing node.  return in found
    non_lose_node = comp_node.children.find{|child| !child.losing_node?(mark)}
    return non_lose_node.prev_move_pos if non_lose_node
    
    # comp_node.children.each do |child|
    #   return child.prev_move_pos if child.winning_node?(mark)
    # end
    
    raise "ERROROROR! It looks like I will lose!"
  end
end

if __FILE__ == $PROGRAM_NAME
  hp = HumanPlayer.new("Justin")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
