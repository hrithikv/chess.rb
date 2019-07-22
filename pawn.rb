class Pawn < Player

  def leaps
    possible_leaps = []
    x,y = @position.dup
    @m = (@color == :white ? 1 : -1)

    possible_leaps << [x + 1*@m,y] if forward_possible?(x + 1*@m, y)
    possible_leaps << [x + 2*@m,y] if first_step?(x, y)
    possible_leaps << [x + 1*@m, y - 1] if is_possible?(x + 1*@m, y - 1)
    possible_leaps << [x + 1*@m, y + 1] if is_possible?(x + 1*@m, y + 1)

    possible_leaps
  end

  def to_s
    @color == :white ? "\u2659" : "\u265F"
  end

  private

  def is_possible?(x, y)
    unless @gameboard[[x,y]].nil?
      @gameboard[[x,y]].color != @color unless forward_possible?(x,y)
    end
  end

  def forward_possible?(x,y)
    @gameboard[[x,y]].nil? && on_board?([x, y])
  end

  def first_step?(x,y)
    pawn_row = (@color == :white ? 1 : 6)

    forward_possible?(x + 2*@m,y) &&
    forward_possible?(x + 1*@m, y) &&
    @position[0] == pawn_row
  end

end
