class Board

    # Create a new board, initialize with with all "b" and
    # save the size of it.
    def initialize(n)
        @n = n
        @board = Array.new(n)
        @board.map! { Array.new(n, "b") }
    end

    # Print the current board.
    def print_board
        puts "Board:"
        @board.each_index do |row|
            @board.each_index do |col|
                print "#{@board[row][col]}"
            end
            puts
        end
    end

    # Check if the row is safe by looping through each of the 
    # columns in the row.
    def safe_row(suggested_row)
        0.upto(@n-1) do |col|
            return false if @board[suggested_row][col] == "Q"
        end

        return true
    end

    # Check if the column is safe by looping through each of the 
    # rows in the row.
    def safe_col(suggested_col)
        0.upto(@n-1) do |row|
            return false if @board[row][suggested_col] == "Q"
        end

        return true
    end

    # Loop through in one diagonal direction to determine if the 
    # suggested row and column are safe.
    def safe_diag(suggested_row, suggested_col, row_mod, col_mod)
        row,col = suggested_row+row_mod, suggested_col+col_mod
        while true do

            # Break out of the loop if the row or column is off the board.
            break if (row >= @n) || (col >= @n) || (row < 0) || (col < 0)

            # If this row or column has a queen, then it's not safe.
            return false if @board[row][col] == "Q"
                
            # Move in the appropriate direction.
            row += row_mod
            col += col_mod
        end

        # This direction is safe.
        return true
    end

    def safe(suggested_row, suggested_col)

        # Check the rows and columns for safe.
        return false if !safe_row(suggested_row)
        return false if !safe_col(suggested_col)

        # Check the diagonals for safe.
        return false if !safe_diag(suggested_row, suggested_col, 1, 1)
        return false if !safe_diag(suggested_row, suggested_col, 1, -1)
        return false if !safe_diag(suggested_row, suggested_col, -1, 1)
        return false if !safe_diag(suggested_row, suggested_col, -1, -1)

        # Should be OK.
        return true
    end

    # Solve the n-queens problem by making a call to the recursive solve_1
    # method with 0 (the first row of the board) to start.
    def solve
        solve_1(0)
    end

    # The recursive method (by row) that loops through the columns and checks
    # if the row given and the column are "safe". If they are we add a "Q" to
    # the position and if the row is 0, we print it out (everthing is
    # complete). If it's safe adn we aren't at 0 we move to the next row
    # recursively.  Finally, we reset the position to "b" (blank) when we
    # return from the recursive call or from printing the board.  If it's not
    # "safe" then we just move to the next column and try that one.
    def solve_1(row)
        0.upto(@n-1) do |col|
            if safe(row, col)
                @board[row][col] = "Q"
                if row == (@n-1)
                    print_board
                else
                    solve_1(row+1)
                end
                @board[row][col] = "b"
            end
        end
    end
end