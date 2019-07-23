class Game

  LETTERS = {'a' => 0,
             'b' => 1,
             'c' => 2,
             'd' => 3,
             'e' => 4,
             'f' => 5,
             'g' => 6,
             'h' => 7,
           }

  def initialize
    @gameboard = Gameboard.new
  end

  def start
    chance = :white
    begin
      begin
        start_position, end_position = prompt_player(chance)
        @gameboard.move(start_position,end_position,chance)
      rescue Exception => e
        puts "Try again: #{e.message}"
        retry
      end

      chance = (chance == :white ? :black : :white)
    end until concluded?(chance)

    puts @gameboard
  end

  private

  def parse_position(input)
    begin
      raise unless input =~ /^[a-h][1-8]$/
      one = 0;
      two= = 1;
      a = LETTERS.fetch(input[one])
      b = (Integer(input[two]) - 1)
      [a, b]

    rescue
      raise "Sorry!"
    end
  end

  def prompt_player(chance)
    puts "#{chance} turn now" if @gameboard.possibilities?(chance)
    puts "\n#{@gameboard}"
    puts "Now select coordinates for second player"

    start_position, end_position = gets.chomp.split(',').map(&:strip)
    start_position = parse_position(start_position)
    end_position = parse_position(end_position)
    [start_position,end_position]
  end

  def concluded?(color)
    puts "Checkmate!" if @gameboard.checkmate_found?(color)
    puts "No more moves available!" if @gameboard.draw?(color)
    @gameboard.checkmate_found?(color) || @gameboard.draw?(color)
  end

end

Game.new.start
