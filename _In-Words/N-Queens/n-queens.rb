class ChessBoard

	BOARDSIZE = 8

	attr_reader :queen_positions

	def initialize(board = Array.new(BOARDSIZE) { Array.new(BOARDSIZE) }, queen_positions = [])
		@board = board
		@queen_positions = queen_positions
	end

	def zero_out_board #with zeroes
		@board.each_with_index do |row, i|
			row.each_index do |j|
				@board[i][j] = 0
			end
		end
	end

	# def try_solution

	# end

	def solve
		solve_helper(0)
	end


	def place_queen(coords)
		@board[coords.first][coords.last] = 'Q'
		@queen_positions.push(coords)
	end

	def threatened?(coords)
		@queen_positions.any? {|pos| single_threat?(coords, pos)}
	end

	def single_threat?(queen_coords, other_queen_coords)
		#threatened if other queen is in same row, column, or diagonal
		(queen_coords[0] == other_queen_coords[0]) || (queen_coords[1] == other_queen_coords[1]) || ((queen_coords[0] - other_queen_coords[0]) == (queen_coords[1] - other_queen_coords[1]))
	end

	# def n_queens_placed?

	# end

end

board = ChessBoard.new
board.zero_out_board
board.place_queen([3,3])

	# def solve_helper(row)
	# 	(0...BOARDSIZE).each do |col|
	# 		last_pos = @queen_positions.last || [0,0]

	# 		unless single_threat?([row,col], last_pos)
	# 			place_queen( [row,col] )
	# 			if row == BOARDSIZE - 1
	# 				@board
	# 			else
	# 				solve_helper(row + 1)
	# 			end
	# 		end
	# 	end
	# end

		# def solve
	# 	#setting initial queen
	# 	place_queen([6,0])

	# 	(1..BOARDSIZE).each do |i|
	# 		(1..BOARDSIZE).each do |j|
	# 			p [i,j]
	# 			p threatened?([i,j])
	# 			place_queen([i,j]) unless threatened?([i,j])
	# 		end
	# 	end

	# 	@board
	# end