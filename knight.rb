class Knight < Stepping_Player
  def to_s
    @color == :white ? "\u2658" : "\u265E"
  end

  private

  def directions
    [[2,1],[-2,1],[-2,-1],[2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  end
end
