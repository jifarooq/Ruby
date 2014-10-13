class Board
  P1_MARK = "x"
  P2_MARK = "o"
   
  attr_reader :board
  
  def initialize(dim)
    @board = Array.new(dim) { Array.new(dim) }
  end
  
  def check_rows(a_board)
    a_board.each do |row|
      return row.first if row.all? {|term| row.first == term} 
    end
    
    false
  end
  
  def check_diagonal1(a_board)
    result = (0...a_board.length).to_a.all? do |i|
      a_board.first.first == a_board[i][i]
    end
    
    result ? a_board.first.first : result
  end
  
  def check_diagonal2(a_board)
    result = (0...a_board.length).to_a.all? do |i|
      j = a_board.length - i + 1
      a_board.last.first == a_board[i][j]
    end
    
    result ? a_board.last.first : result
  end
    
  def won?
    !!winner
  end
    
  def winner
    (check_rows(@board) || check_rows(@board.transpose) || check_diagonal1(@board) || check_diagonal2(@board))
  end
  
  def place_mark(pos, mark)
    @board[pos.first][pos.last] = mark
  end
  
  def make_move(pos, mark)
    if valid_move?(pos)
      place_mark(pos, mark)
      return true
    end
    false
  end
  
  def valid_move?(pos)
    @board[pos.first][pos.last].nil? && 
    pos.first.between?(0, @board.size) &&
    pos.last.between?(0, @board.size)
  end
  
  def to_s
    @board.map do |row|
      row.map { |r| r.nil? ? " " : r }.join('|') + "\n"
    end
  end

end

class Game
  #loop to play game.  be able to switch players
  MARKS = ["x","o"]
  
  attr_reader :board
  
  def initialize
    @board = Board.new(3)
    @cur_player = 0
  end
  
  def play(player1, player2)
    @players = [player1, player2]
    
    until @board.won?
      puts @board.to_s
      
      loop do
        move = @players[@cur_player].take_move
        break if @board.make_move(move, MARKS[@cur_player])
      end
      
      @cur_player = (@cur_player + 1) % 2
    end

    puts @board.to_s
    puts "Player #{ MARKS.find_index(@board.winner) + 1 } has won!"
  end
    
end


class Player
  
  def take_move 
    loop do
      puts "Where do you want to mark?"
      input = gets.chomp
      pattern = /\s*\d+\s*,\s*\d+\s*/
      return input.match(pattern)[0].split(',').map(&:to_i) if input =~ pattern
    end
  end

end

class HumanPlayer < Player
end

class ComputerPlayer < Player
  
  def initialize(board)
    @board = board
  end
  
  def take_move
    move = [rand(@board.board.size), rand(@board.board.size)]
    puts move
    move
  end

end

if $PROGRAM_NAME == __FILE__
  game = Game.new
  player1 = Player.new
  player2 = ComputerPlayer.new(game.board)
  game.play(player1, player2)
end