class Player

  MOVE_DIAGONAL   = [[1,1],[-1,1],[-1,-1],[1,-1]]
  MOVE_ORTHOGONAL = [[1,0],[0,1],[-1,0],[0,-1]]
  
  attr_accessor :gameboard, :position, :color

  def initialize(gameboard, color, position)
    @gameboard, @color, @position = gameboard, color.to_sym, position
  end
  
  def leaps
    raise NotImplementedError
  end
  
  def on_gameboard?(pos)
    pos.map{|x| x.between?(0, Gameboard::DIMENSION - 1)}.all?
  end
  
  def duplicate(new_gameboard)
    new_position = self.position.duplicate
    self.class.new(new_gameboard, @color, new_position)
  end

  def leap_into_check?(pos)
    new_gameboard = @gameboard.duplicate
    new_self = self.duplicate(new_gameboard)
    new_gameboard.leap!(new_self.position, pos)

    new_gameboard.in_check?(@color)
  end

  def valid_leaps
    self.leaps.reject do |move|
      leap_into_check?(move)
    end
  end

  def inspect
    puts self.class
  end
end


