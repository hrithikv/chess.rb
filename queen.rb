class Queen < Sliding_Piece
  def to_s
    @color == :white ? "\u2655" : "\u265B"
  end

  private

  def directions
    MOVE_ORTHOGONAL + MOVE_DIAGONAL
  end
end
