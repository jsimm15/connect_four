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
    #Initial display of empty game board
    board.display_board
    while !game_over? do
      input = prompt_user_input(@active_player)
      #Call #choose_column, subtracting 1 to account for zero-indexing in Board class
      @board.choose_column(input - 1, @active_player)
      #If placement causes a full board
      if @board.all_spaces_full?
        #Perfom a final check for a winner
        if @board.winner?(@active_player.piece)
          "It looks like #{@active_player.name} is the winner!"
        #If no winner, declare a draw
        else
          @board.tie_game
        end
      end
      #Before switching active_player, it is necessary to remember the previous player
      # in case a win condition is triggered at the start of the next loop
      prev_player = @active_player
      switch_active_player
    end
    #Triggers if the while loop is short-circuited due to win condition
    #Since previous player is the last to play a piece, they must be the winner
    puts "It looks like #{prev_player.name} is the winner!"
  end

  #Prints intro message to screen
  def intro
    puts "Let's play Connect Four!"
  end

  #Prompt and validate user input, only allowing for numbers [1-7] and selection of non-full column
  def prompt_user_input(user)
    puts "It's #{user.name}'s turn. Please select a column [1-7]"
    #Note: Subtract 
    input = gets.chomp until (1..7).include?(input.to_i) && !@board.full?(input.to_i - 1)
    input.to_i
  end

  #Switches active_player to whichever is not currently active
  def switch_active_player
    @active_player == @player1 ? @active_player = @player2 : @active_player = @player1
  end
  
  #Checks for win conditions for both players
  def game_over?
    @board.winner?(@player1.piece) || @board.winner?(@player2.piece)
  end
end

#Starts the game
round = GameRound.new
