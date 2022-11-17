require './lib/main.rb'

describe GameRound do
  
  
  context 'setting up opening game conditions' do
    subject(:game) { described_class.new }
    
      it 'creates a new, empty game board' do
        board = game.board
      end
      
      it 'creates an instance of Player called player1' do
        player1 = game.player1
        expect(player1).to be_an_instance_of(Player)
      end
      
      it 'creates an instance of Player called player 2' do
        player2 = game.player2
        expect(player2).to be_an_instance_of(Player)
      end

      it 'sets player1 as the active_player' do
        expect(game.active_player).to be(player1)
      end
   
  end

    
  describe 'game_loop' do
  end

  describe "switch_active_player" do
    subject(:game) { described_class.new }
    context 'active_player is currently Player 1' do
      it "updates active_player from Player 1 to Player 2" do
        expect { game.switch_active_player }.to change { game.active_player}.from(player1).to(player2)
        game.switch_active_player
      end
    end
    context 'active_player is currently Player 2' do
      it 'changes active_player from Player 2 to Player 1' do
        game.active_player = player2
        expect { game.switch_active_player }.to change { game.active_player }.from(player2).to(player1)
        game.switch_active_player
      end 
    end
  end
  


end