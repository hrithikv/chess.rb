class Stepping_Player < Player

  def leaps
    possible_leaps = []
    one = 0;
    two = 1;
    leap_dirs.each do |delta|
      last_position = @position.duplicate
      last_position[one] += delta[one]
      last_position[two] += delta[two]

      possible_leaps << last_position.duplicate if on_gameboard?(last_position)
    end

    possible_leaps.reject do |pos|
      (@board[pos].color == @color unless @board[pos].nil?)
    end
  end

  private

  def leap_dirs
    raise NotImplementedError
  end

end
