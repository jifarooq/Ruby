# require './00_tree_node.rb'
class Queens 

	BOARDSIZE = 8

		def initialize(board = Array.new(BOARDSIZE) { Array.new(BOARDSIZE) }, start_pos = [0,0])
		@board = board
		@start_pos = [0,0]
	end

	def safe_row(row)
		(0...BOARDSIZE).each do |col|
			return false if @board[row, col] == 'Q'
		end

		true
	end

	def safe_col(col)
		(0...BOARDSIZE).each do |row|
			return false if @board[row, col] == 'Q'
		end

		true
	end

	def safe_diag(row, col, offsets)
    row, col = row + offsets[0], col + offsets[1]

    while (row < BOARDSIZE) && (col < BOARDSIZE) && (row > 0) && (col > 0)
      return false if @board[row][col] == "Q" 
        row += offsets.first
        col += offsets.last
    	end

    return true
  end

  #safe on rows, columns, and diagonals
  def safe(row, col)
  	return false if !safe_row(row) || !safe_col(col)
  	diag_offsets = [ [-1,-1], [-1,1], [1,-1], [1,1]]
  	diag_offsets.all? { |offset| safe_diag(row,col,offset) }
  end

  def solve
  	#return true if all queens are placed
  	return true if @board.flatten.select{|pos| pos == 'Q'}.size == BOARDSIZE

  	(0...BOARDSIZE) do |row|
  		
  end

end