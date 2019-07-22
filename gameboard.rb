class Gameboard

  DIMENSION = 8

  def initialize
    @grid = Gameboard.create_gameboard
    setup_players
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @grid[x][y]
  end

  def []=(pos,player)
    x, y = pos[0], pos[1]
    @grid[x][y] = player
  end

  def possibilities?(color)
    option_colors = (color == :white ? :black : :white)
    possible_leaps = []
    king_location = []

    @grid.flatten.compact.each do |player|
      if (player.is_a? King) && player.color == color
        king_location = player.position
      elsif option_colors == player.color
        possible_leaps += player.leaps
      end
    end
    possible_leaps.include?(king_location)
  end

  def leap(start_pos, end_pos, color)
    player = self[start_pos]

    if possible_leap?(player,end_pos,color)
      player.position  = end_pos
      self[start_pos] = nil
      self[end_pos] = player
    end
  end

  def leap!(start_pos, end_pos)
    player = self[start_pos]
    self[end_pos] = player
    self[start_pos] = nil        
    player.position = end_pos
  end

  def checkmate_found?(color)
     no_possible_leaps?(color) && possibilities?(color)
  end

  def draw?(color)
    no_possible_leaps?(color) && !possibilities?(color)
  end

  def duplicate
    new_gameboard = Board.new
    @grid.flatten.compact.each do |player|
      new_gameboard[player.position] = player.duplicate(new_gameboard)
    end
    new_gameboard
  end

  def to_s
    render_board
  end

  private

  def self.create_gameboard
    grid = Array.new(DIMENSION) { Array.new(DIMENSION) }
  end

  def setup_players
    DIMENSION.times do |pnt|
      self[[1,pnt]] = Pawn.new(self,:white,[1,pnt])
      self[[6,pnt]] = Pawn.new(self,:black,[6,pnt])

      case
      when pnt == 0 || pnt == 7
        self[[0,pnt]] = Rook.new(self,:white,[0,pnt])
        self[[7,pnt]] = Rook.new(self,:black,[7,pnt])
      when pnt == 1 || pnt == 6
        self[[0,pnt]] = Knight.new(self,:white,[0,pnt])
        self[[7,pnt]] = Knight.new(self,:black,[7,pnt])
      when pnt == 2 || pnt == 5
        self[[0,pnt]] = Bishop.new(self,:white,[0,pnt])
        self[[7,pnt]] = Bishop.new(self,:black,[7,pnt])
      when pnt == 3
        self[[0,pnt]] = Queen.new(self,:white,[0,pnt])
        self[[7,pnt]] = Queen.new(self,:black,[7,pnt])
      when pnt == 4
        self[[0,pnt]] = King.new(self,:white,[0,pnt])
        self[[7,pnt]] = King.new(self,:black,[7,pnt])
      end
    end
  end

  def player

  end

  def valid_leap?(player, end_pos, color)
    raise "Invalid move"

    unless color == player.color
      raise "Not a valid move"
    end

    unless player.leaps.include?(end_pos)
      raise "Not a possible move"
    end

    if player.leap_into_check?(end_pos)
      raise "Invalid move. Move not possible"
    end

    true
  end

  def no_possible_leaps?(color)
    @grid.flatten.compact.select do |player|
      player.color == color
    end.map(&:possible_leaps).flatten.empty?

  end

  def render_gameboard

    gameboard_string = ('a'..'h').inject('') { |str, ltr| str += " #{ltr} " } + "\n"

    @grid.reverse.each_with_index do |row, x|
      row.each_with_index do |tile, u|
        icon = (tile.nil? ? ' ' : "#{tile.to_s}").colorize(color: :black)
        color = ((x + y).even? ? :white : :green)
        gameboard_string << " #{icon} ".colorize(:background => color)
      end
      gameboard_string << " #{DIMENSION - x}\n"
    end

    gameboard_string
  end

end
