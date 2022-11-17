class GameBoard
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) { "| |" } }
    @available_rows = Array.new(7) { 5 }
  end

  def display_board
    grid.each do |row|
      puts row.join(' ')
    end
    print ' '
    puts (1..7).to_a.join('   ')
    end

  def update_board(row, column, piece)
    while @grid[row][column] != '| |' do
      row -= 1
    end
    @grid[row][column] = piece
    self.display_board
  end

  def choose_column(column, player)
    if full?(column)
      begin
        raise StandardError.new "Column full. Try again"
      rescue => e
        puts e.message
        #self.choose_column(column + 1, player)
      end
    end
    row = current_row(column)
    self.update_board(row, column, player.piece)
  end

  def current_row(column)
    row = @available_rows[column]
    while @grid[row][column] != '| |' do
      row -= 1
      @available_rows[column] -= 1
    end
    row
  end

  def full?(column)
    @grid[0][column] == "|X|" || @grid[0][column] == "|O|"
  end

  def all_spaces_full?
    columns = (0..6).to_a
    columns.all? {|column| full?(column) }
  end

  def tie_game
    puts "All spaces have been filled. It's a draw!"
    exit
  end

  def winner?(piece)
    check_verticals(piece) || check_horizontals(piece) || check_diagonals(piece)
  end

  def check_verticals(piece)
    # matcher = "|X|"
    # count = 0
    # [0..6].each do |column|
    #   [0..5].each do |row|
    #     if @grid[row][column] == matcher
    #       p matcher
    #       count += 1
    #       if count == 4
    #         return true
    #       end
    #     else
    #       count = 1
    #       matcher = @grid[row][column]
    #     end
    #   end
    # end
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

  def check_diagonals(piece)
    check_left_diagonal(piece) || check_right_diagonal(piece)
  end

  def check_right_diagonal(piece)
    rows = [5, 4, 3, 2]
    columns = [0, 1, 2, 3]
    shift = 0

    while rows[-1] >= 0 && columns[-1] < 7 do
      return true if rows.all? { |row| @grid[row][5 - row - shift] == piece} 
      #&& columns.all? { |column| @grid[5 - column][column] == piece}

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

  def check_left_diagonal(piece)
    rows = [0, 1, 2, 3]
    columns = [0, 1, 2, 3]
    shift = 0

    while rows[-1] < 6 && columns[-1] < 7 do
      return true if rows.all? { |row| @grid[row][row - shift] == piece} 
      #&& columns.all? { |column| @grid[5 - column][column] == piece}

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
