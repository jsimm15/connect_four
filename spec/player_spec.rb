require './lib/player.rb'

describe Player do

  context 'creating a new player' do
    player1 = Player.new('Player 1', 'X')
    player2 = Player.new('Player 2', 'O')

    it 'returns "Player 1" as the name of player1'do
      expect(player1.name).to eq("Player 1")
    end

    it 'returns "X" as the game piece for player1' do
      expect(player1.piece).to eq ("X")
    end
     
    it 'returns "Player 2" as the name for player2' do
      expect(player2.name).to eq("Player 2")
    end

    it 'returns "O" as the game piece for player2' do
      expect(player2.piece).to eq("O")
   end
  end


end
