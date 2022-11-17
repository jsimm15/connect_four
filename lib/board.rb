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
    @grid[0][column] != "| |"
  end

  def winner?
    check_verticals || check_horizontals || check_diagonals
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

  def check_horizontals
    # matcher = ""
    # count = 0
    # [0..5].each do |row|
    #   [0..6] do |column|
    #     if column == 0
    #       matcher 
  end

  def check_diagonals
  end

  # def check_right_diagonal
  # end

  # def check_left_diagonal
  # end

end
