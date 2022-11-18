class GameBoard
  attr_reader :grid

  #Creates a 6 x 7 grid of "empty" "| |" elements
  def initialize
    @grid = Array.new(6) { Array.new(7) { "| |" } }
  end

  #Prints the current representation of @grid
  def display_board
    grid.each do |row|
      puts row.join(' ')
    end
    print ' '
    puts (1..7).to_a.join('   ')
    end

  #Finds the next empty row in the selected column and sets it equal to @active_player.piece
  def update_board(column, piece)
    row = 5
    while @grid[row][column] != '| |' do
      row -= 1
    end
    @grid[row][column] = piece
    self.display_board
  end

  #Checks to make sure column is not full and then passes value to update_board
  #This method is somewhat redundant since main.rb handles verification of user input already
  #For this reason, the rescue block here should never trigger
  def choose_column(column, player)
    if full?(column)
      begin
        raise StandardError.new "Column full. Try again"
      rescue => e
        puts e.message
      end
    end
    self.update_board(column, player.piece)
  end

  #Checks for an empty row in the selected column, returns true if occupied, false if empty
  def full?(column)
    @grid[0][column] == "|X|" || @grid[0][column] == "|O|"
  end

  #Applies #full? to every column, checking for a full board
  def all_spaces_full?
    columns = (0..6).to_a
    columns.all? {|column| full?(column) }
  end

  #Method to print result to screen and exit program in the event of a draw
  def tie_game
    puts "All spaces have been filled. It's a draw!"
    exit
  end

  #Checks all winning conditions, returning true if any are met
  def winner?(piece)
    check_verticals(piece) || check_horizontals(piece) || check_diagonals(piece)
  end

  #Checks each column for a vertical sequence of 4 matching symbols
  def check_verticals(piece)
    column = 0
    rows = [0, 1, 2, 3]

    while column < 7 do 
      return true if rows.all? { |row| @grid[row][column] == piece }
      
      rows.map! { |row| row += 1 }
      
      if rows[-1] == 6
        column += 1
        rows = [0, 1, 2, 3]
      end  
    end
    return false
  end

  #Check each row for a horizontal sequence of 4 matching symbols
  def check_horizontals(piece)
    row = 0
    columns = [0, 1, 2, 3]

    while row < 6 do
      return true if columns.all? { |column| @grid[row][column] == piece }

      columns.map! { |column| column += 1 }

      if columns[-1] == 7
        row += 1
        columns = [0, 1, 2, 3]
      end
    end
    return false
  end

  #Helper to call the 2 diagonal matching methods
  def check_diagonals(piece)
    check_left_diagonal(piece) || check_right_diagonal(piece)
  end

  #Checks for a left-to-right upwards diagonal sequence of 4 mathing symbols
  def check_right_diagonal(piece)
    rows = [5, 4, 3, 2]
    columns = [0, 1, 2, 3]
    shift = 0

    #Shift factor allows for moving rows and columns arrays in lockstep
    while rows[-1] >= 0 && columns[-1] < 7 do
      return true if rows.all? { |row| @grid[row][5 - row - shift] == piece} 
      
      columns.map! { |column| column += 1 }
      shift -= 1

      if columns[-1] == 7
        rows.map! { |row|  row -= 1 }
        columns = [0, 1, 2, 3]
        shift = 5 - rows[0]
      end
    end
    return false
  end

  #Checks for a left-to-right downwards diagonal sequence of 4 mathcing symbols
  def check_left_diagonal(piece)
    rows = [0, 1, 2, 3]
    columns = [0, 1, 2, 3]
    shift = 0

    while rows[-1] < 6 && columns[-1] < 7 do
      return true if rows.all? { |row| @grid[row][row - shift] == piece} 

      columns.map! { |column| column += 1 }
      shift -= 1

      if columns[-1] == 7
        rows.map! { |row|  row += 1 }
        columns = [0, 1, 2, 3]
        shift = rows[0]
      end
    end
    return false
  end
end
