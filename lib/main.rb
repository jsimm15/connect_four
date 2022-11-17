require_relative 'board.rb'
require_relative 'player.rb'

class GameRound
  attr_accessor :board, :player1, :player2, :active_player
  def initialize
    @board = GameBoard.new
    @player1 = Player.new('Player 1', '|X|')
    @player2 = Player.new('Player 2', '|O|')
    @active_player = @player1
    self.intro
    self.game_loop
  end
  
  #Game loop
  def game_loop
    board.display_board
    while !game_over? do
      input = prompt_user_input(@active_player)
      @board.choose_column(input - 1, @active_player)
      if @board.all_spaces_full?
        if @board.winner?(@active_player.piece)
          "It looks like #{@active_player.name} is the winner!"
        else
          @board.tie_game
        end
      end
      prev_player = @active_player
      switch_active_player
    end
    puts "It looks like #{prev_player.name} is the winner!"
  end

  def intro
    puts "Let's play Connect Four!"
  end

  def prompt_user_input(user)
    puts "It's #{user.name}'s turn. Please select a column [1-7]"
    input = gets.chomp until (1..7).include?(input.to_i) && !@board.full?(input.to_i - 1)
    input.to_i
  end

  def switch_active_player
    @active_player == @player1 ? @active_player = @player2 : @active_player = @player1
  end
  
  def game_over?
    @board.winner?(@player1.piece) || @board.winner?(@player2.piece)
  end
end

round = GameRound.new
# round.board.update_board(-1,0,"[X]")
# round.board.update_board(-1,0,"[O]")
# round.board.update_board(-1,0,"[X]")
# round.board.update_board(-1,0,"[O]")

# round.board.choose_column(0,round.player1)
# round.board.choose_column(0,round.player1)
# round.board.choose_column(0,round.player1)
# round.board.choose_column(0,round.player1)
# p round.board.check_verticals