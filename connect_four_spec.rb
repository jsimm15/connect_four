require_relative 'connect_four.rb'

describe GamePiece do 
  
  subject(:piece) { described_class.new }
  
  it 'has @marker value of "[=]" when piece has not been selected' do
    expect(piece.marker).to eq("[=]")
  end

  describe 'select_square' do
  
    it 'changes @marker to "[X]" when Player 1 selects the current piece' do
      active_player = 1
      expect { piece.select_square(active_player) }.to change { piece.marker }.to("[X]")
    end

    it 'changes @marker to "[O]" when Player 2 selects the current piece' do
      active_player = 2
      expect { piece.select_square(active_player) }.to change { piece.marker }.to("[O]")
    end
  end

end