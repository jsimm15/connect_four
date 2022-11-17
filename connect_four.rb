class GamePiece
  attr_accessor :selected, :marker
  def initialize
    @selected = false
    @marker = "[=]"
  end

  def selected?
    @selected
  end

  def select_square(active_player)
    if self.selected?
      raise StandardError.new "Cannot select a square, already selected"
    end
  
    case active_player
    when 1
      @marker = "[X]"
    when 2
      @marker = "[O]"
    end
    @selected = true
    
  end

end