require './lib/board.rb'

describe GameBoard do

  # describe display_board do
  #   context 'when creating a new board' do 
  #     it 'displays a grid of 6 rows, 7 columns, with marked by "|"' do
  #       expect
  #     end
  #   end
  # end

  describe "current_row" do
    subject(:board) { described_class.new }
    context 'when column is empty' do 
      it 'returns 5' do
        expect(board.current_row(0)).to eq(5)
      end
    end
    context 'when there are two occupied row in the column' do
      it 'returns 3' do
        board.grid[5][0] = "|X|"
        board.grid[4][0] ="|O|"
        expect(board.current_row(0)).to eq(3)
      end
    end
    context 'the first 5 rows of the column are occupied' do
      it 'returns 0' do
        (1..5).each do |row|
          board.grid[row][0] = "|X|"
        end
        expect(board.current_row(0)).to eq(0)
      end
    end
  
  end

  describe 'update_board' do
    subject(:board) { described_class.new }
    let(:game) { instance_double('gameround') }
    context 'when the board is empty and player chooses column[0]' do
      it 'updates the value at grid[-1][0] to be equal to |X|' do
        expect { board.update_board(5,0,"|X|") }.to change { board.grid[-1][0] }.from("| |").to("|X|")
      end
    end
    context 'when the selected column has two occupied rows' do
      it 'updates the value at grid[3][0] to be "|X|' do
        board.grid[-1][0] = "|X|"
        board.grid[-2][0] = "|O|"
        expect { board.update_board(5,0,"|X|") }.to change { board.grid[-3][0] }.from("| |").to("|X|")
      end
    end
  end

  describe 'choose_column' do
    subject(:board) { described_class.new }
    let(:player) { instance_double('player', piece: "|X|") }
    context 'when the board is empty' do
      it 'sends the selected column to #current_row' do
        column = 0
        expect(board).to receive(:current_row).with(column).once
        board.current_row(column)
      end
      it 'calls #update_board' do
        column = 0
        allow(board).to receive(:current_row).and_return(5)
        expect(board).to receive(:update_board).with(5,0,"|X|").once
        board.choose_column(column, player)
      end
    end
    context 'when the column is full' do
      it 'raises a StandardError' do
        column = 0
        board.grid[5][column] = "|O|"
        board.grid[4][column] = "|X|"
        board.grid[3][column] = "|O|"
        board.grid[2][column] = "|X|"
        board.grid[1][column] = "|O|"
        board.grid[0][column] = "|X|"
        board.display_board
        #allow(board).to receive(:full?).and_return(true)
        expect { board.choose_column(column, player) }.to raise_error(StandardError)
        #board.choose_column(column, player)
      end
    end
  end

  describe 'full?' do 
    subject(:board) { described_class.new }
    let(:player) { instance_double('player', piece: "|X|")}
    context 'when the selected column is not full' do
      it 'returns false' do
        column = 0
        expect(board).to receive(:full?).and_return(false)
        board.full?(column)
      end
    end
    context 'when the selected column is full' do 
      it 'returns true' do
        column = 0
        board.grid[5][column] = "|O|"
        board.grid[4][column] = "|X|"
        board.grid[3][column] = "|O|"
        board.grid[2][column] = "|X|"
        board.grid[1][column] = "|O|"
        board.grid[0][column] = "|X|"
        expect(board).to receive(:full?).and_return(true)
        board.full?(column)
      end
    end
  end

  describe 'all_spaces_full?' do
    context 'when the entire board is not full' do
      subject(:board) { described_class.new }
      it 'returns false' do
        expect(board.all_spaces_full?).to be(false)
      end
    end
    context 'when the entire board is full' do
      subject(:board2) { described_class.new }
      before do
        (0..5).each do |row|
          (0..6).each do |col|
            board2.grid[row][col] = "|O|"
          end
        end
      end
        it 'returns true' do
          expect(board2.all_spaces_full?).to be(true)
        end
      end
  end


  describe 'winner?' do
    subject(:board) { described_class.new }
    context 'when none of the win conditions have been met' do
      it 'returns false' do
        allow(board).to receive(:check_verticals).and_return(false)
        allow(board).to receive(:check_horizontals).and_return(false)
        allow(board).to receive(:check_diagonals).and_return(false)
        expect(board.winner?("|X|")).to be(false)
      end
    end
    context 'when at least one of the win conditions has been met' do
      it 'returns true' do
        allow(board).to receive(:check_verticals).and_return(false)
        allow(board).to receive(:check_horizontals).and_return(false)
        allow(board).to receive(:check_diagonals).and_return(true)
        expect(board.winner?("|X|")).to be(true)
      end
    end
  end

  describe 'check verticals' do
    context 'when there is no vertical sequence of 4 matching symbols' do
      subject(:board) { described_class.new }
      it 'returns false' do
        column = 0
        board.grid[5][column] = "|O|"
        board.grid[4][column] = "|X|"
        board.grid[3][column] = "|O|"
        board.grid[2][column] = "|X|"
        board.grid[1][column] = "|O|"
        board.grid[0][column] = "|X|"
        expect(board.check_verticals("|X|")).to be(false)
        #board.check_verticals
      end
    end
    context 'when there exists a vertical sequence of 4 matching symbols' do
      subject(:board) { described_class.new }
      it 'returns true' do
        column = 0
        board.grid[5][column] = "|O|"
        board.grid[4][column] = "|X|"
        board.grid[3][column] = "|X|"
        board.grid[2][column] = "|X|"
        board.grid[1][column] = "|X|"
        board.grid[0][column] = "|O|"
        expect(board.check_verticals("|X|")).to be(true)
        #board.check_verticals
      end
    end  
  end

  describe 'check_horizontals' do
    context 'when there is no horizontal sequence of 4 matching symbols' do
      subject(:board) { described_class.new }
      it 'returns false' do
        row = 5
        board.grid[row][0] = "|O|"
        board.grid[row][1] = "|X|"
        board.grid[row][2] = "|X|"
        board.grid[row][3] = "|O|"
        board.grid[row][4] = "|X|"
        board.grid[row][5] = "|O|"
        expect(board.check_horizontals("|X|")).to be (false)
      end
    end
    context 'when there exists a horizontal sequence of 4 matching symbols' do
      subject(:board) { described_class.new }
      it 'returns true' do
        row = 5
        board.grid[row][0] = "|O|"
        board.grid[row][1] = "|X|"
        board.grid[row][2] = "|X|"
        board.grid[row][3] = "|X|"
        board.grid[row][4] = "|X|"
        board.grid[row][5] = "|O|"
        expect(board.check_horizontals("|X|")).to be(true)
      end
    end

  end

  describe 'check_diagonals' do
    context 'there is no diagonal sequence of 4 matching symbols' do
      subject(:board) { described_class.new }
      it 'returns false' do
        allow(board).to receive(:check_left_diagonal).and_return(false)
        allow(board).to receive(:check_right_diagonal).and_return(false)
        expect(board.check_diagonals("|X|")).to be(false)
      end
    end
    context 'there exists a diagonal sequence of 4 matching symbols' do
      subject(:board) { described_class.new }
      it 'returns true' do
        allow(board).to receive(:check_left_diagonal).and_return(false)
        allow(board).to receive(:check_right_diagonal).and_return(true)
        expect(board.check_diagonals("|X|")).to be(true)
      end
    end
  end

  describe 'check_right_diagonal' do
    context 'there is no sequence of 4 matching characters in a left-to-right upwards diagonal' do
      subject(:board) { described_class.new }
      it 'returns false' do
        board.grid[5][0] = "|O|"
        board.grid[4][1] = "|X|"
        board.grid[3][2] = "|X|"
        board.grid[2][3] = "|O|"
        board.grid[1][4] = "|X|"
        board.grid[0][5] = "|O|"
        expect(board.check_right_diagonal("|X|")).to be(false)
      end
    end
    context 'there exists a sequence of 4 matching characters in a left-to-right upwards diagonal' do
      subject(:board) { described_class.new }
      before do
        (0..5).each do |row|
          (0..6).each do |col|
            board.grid[row][col] = "|O|"
          end
        end
      end
      
      it 'returns true' do

        board.grid[5][0] = "|O|"
        board.grid[4][1] = "|X|"
        board.grid[3][2] = "|X|"
        board.grid[2][3] = "|X|"
        board.grid[1][4] = "|X|"
        board.grid[0][5] = "|O|"
        expect(board.check_right_diagonal("|X|")).to be(true)
      end
    end
  end

  describe 'check_left_diagonal' do 
    context 'there is no sequence of 4 matching characters in a left-to-right downwards diagonal' do
      subject(:board) { described_class.new }
      it 'returns false' do
        board.grid[0][0] = "|O|"
        board.grid[1][1] = "|X|"
        board.grid[2][2] = "|X|"
        board.grid[3][3] = "|O|"
        board.grid[4][4] = "|X|"
        board.grid[5][5] = "|O|"
        expect(board.check_left_diagonal("|X|")).to be(false)
      end
    end
    context 'there exists a sequence of 4 matching characters in a left-to-right downwards diagonal' do
      subject(:board) { described_class.new }
      before do
        (0..5).each do |row|
          (0..6).each do |col|
            board.grid[row][col] = "|O|"
          end
        end
      end
      it 'returns true' do
        board.grid[0][0] = "|O|"
        board.grid[1][1] = "|X|"
        board.grid[2][2] = "|X|"
        board.grid[3][3] = "|X|"
        board.grid[4][4] = "|X|"
        board.grid[5][5] = "|O|"
        expect(board.check_left_diagonal("|X|")).to be(true)
      end
    end
  end
  
end