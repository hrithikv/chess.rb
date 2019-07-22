class Sliding_Player < Player

  def leaps
    possible_leaps = []
    move_dirs.each do |delta|

     last_pos = @position.duplicate

      loop do
        last_pos[0] += delta[0]
        last_pos[1] += delta[1]
        break unless on_gameboard?(last_pos)
        break if own_player?(last_pos)
        if opp_player?(last_pos)
          possible_leaps << last_pos   
          break
        end
        possible_leaps << last_pos.duplicate

      end
    end
    possible_leaps
  end

  private

  def move_dirs
    raise NotImplementedError
  end

  def own_player?(pos)
    @gameboard[pos].color == @color unless @gameboard[pos].nil?
  end

  def opp_player?(pos)
    @gameboard[pos].color != @color unless @gameboard[pos].nil?
  end

end
