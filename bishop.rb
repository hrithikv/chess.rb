class Bishop < Sliding_Player
  def to_s
    @color == :white ? "\u2657" : "\u265D"
  end

  private

  def directions
    MOVE_DIAGONAL
  end
end
