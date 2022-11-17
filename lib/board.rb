class GameBoard
  attr_reader :grid

  def initialize
    @grid = Array.new(6) { Array.new(7) { "| |" } }
    @available_rows = Array.new(7) { 6 }
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
    @grid[row][column]= piece
    self.display_board
  end

  def choose_column(column,player)
    if full?(column)
      raise StandardError "Column full. Try again"
    end
    self.update_board(-1,column, player.piece)
  end


  def full?(column)
    @grid[0][column] != "| |"
  end

  # def winner?
  # end

  # def check_verticals
  # end

  # def check_horizontals
  # end

  # def check_diagonals
  # end

  # def check_right_diagonal
  # end

  # def check_left_diagonal
  # end

end
