require_relative 'Minesweeper'

class Game
  attr_reader :player, :board, :bomb_count
  attr_accessor :moves, :name, :flags_placed

  def initialize(board = Minesweeper.default_grid, bomb_count = 5)
    @bomb_count = bomb_count
    @board  = Minesweeper.new(board, bomb_count)
    @moves = 0
    @name = name
    @flags_placed = 0
  end

  def play
    puts "What's your name?"
    name = gets.chomp
    puts "Hey, #{name}. Are you ready??? to get?? owned??!?"
    puts "You must find #{bomb_count} bombs"
    board.display
    until board.over?
      puts "Moves taken: #{moves} \t Bombs remaining: #{bomb_count - flags_placed}"
      turn = get_move

      if turn.last == "f"
        board.flag_bomb(turn.first)
        self.flags_placed += 1
      elsif turn.last == "r"
        board.reveal(turn.first)
      elsif turn.last == "u"
        board.unflag_bomb(turn.first)
        self.flags_placed -= 1
      end

      system("clear")
      board.display
      self.moves += 1
    end

    if board.won?
      puts " yey"
    else
      puts "oh no"
    end
  end

  def get_move
    [get_spot, get_mark]
  end

  def get_spot
    puts "What spot would you like to reveal????????? (row, col)"
    spot = nil
    until valid_spot?(spot)
      spot = gets.chomp.split(", ").map(&:to_i)
      puts "Please enter a valid spot" unless valid_spot?(spot)
    end
    spot
  end

  def get_mark
    puts "Do you want to flag or reveal this spot? (f or r)"
    mark = nil
    until valid_mark?(mark)
      mark = gets.chomp.downcase
      puts "Please type f, r, or u to flag, reveal, or unflag" unless valid_mark?(mark)
    end
    mark
  end

  def valid_spot?(spot)
    spot.is_a?(Array) && spot.length == 2 && spot.first < 9 &&
    spot.first >= 0 && spot.last < 9 && spot.last >= 0
  end

  def valid_mark?(mark)
    !mark.nil? && (mark == "f" || mark == "r" )
  end
end

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end
