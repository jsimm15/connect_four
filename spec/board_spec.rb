require './lib/board.rb'

describe GameBoard do

  # describe display_board do
  #   context 'when creating a new board' do 
  #     it 'displays a grid of 6 rows, 7 columns, with marked by "|"' do
  #       expect
  #     end
  #   end
  # end

  describe 'update_board' do
    subject(:board) { described_class.new }
    context 'when the board is empty and player chooses column[0]' do
      it 'updates the value at grid[0][-1] to be equal to [X]' do
        board.grid.update_board(0,-1,'|X|') 
        expect(board.grid[-1][0]).to eq("|X|")
      end
    end
  end

  # describe 'full?' do
  # end

  # describe 'winner?' do 
  # end

  # describe check_verticals do 
  # end

  # describe check_horizontals do 
  # end

  # describe check_diagonals do 
  # end

  # describe check check_right_diagonal do
  # end

  # describe check_left_diagonal do 
  # end
  
end