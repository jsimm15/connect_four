require_relative 'board.rb'
require_relative 'player.rb'

class GameRound
  attr_accessor :board, :player1, :player2, :active_player
  def initialize
    @board = GameBoard.new
    @player1 = Player.new('Player 1', '|X|')
    @player2 = Player.new('Player 2', '|O|')
    @active_player = @player1
    self.game_loop
  end
  
  #Game loop
  def game_loop
    board.display_board
    # while !game_over? do
    #   puts "#{@active_player.name} please select a column [1-7]: }"
    #   input = gets.chomp.to_i
    #   @board.choose_column(input,@active_player)
    # end
  end

  def switch_active_player
    @active_player == @player1 ? @active_player = @player2 : @active_player = @player1
  end
  
end

round = GameRound.new
# round.board.update_board(-1,0,"[X]")
# round.board.update_board(-1,0,"[O]")
# round.board.update_board(-1,0,"[X]")
# round.board.update_board(-1,0,"[O]")

round.board.choose_column(0,round.player1)
round.board.choose_column(0,round.player2)
round.board.choose_column(0,round.player1)
round.board.choose_column(0,round.player2)