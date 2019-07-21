class King < Stepping_Player
  def to_s
    @color == :white ? "\u2654" : "\u265A"
  end

  private

  def directions
    MOVE_ORTHOGONAL + MOVE_DIAGONAL
  end
end
