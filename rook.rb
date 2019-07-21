class Rook < Sliding_Player

  def to_s
    @color == :white ? "\u2656" : "\u265C"
  end

  private

  def directions
    MOVE_ORTHOGONAL
  end
end
