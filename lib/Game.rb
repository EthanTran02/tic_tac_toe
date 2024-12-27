require_relative 'Board'
require_relative 'Player'

class Game # rubocop:disable Style/Documentation
  def initialize(marker1, marker2)
    @player1 = Player.new(marker1)
    @player2 = Player.new(marker2)
    @board = Board.new
    @current_player = @player1
  end

  def play
    loop do
      puts "Player #{@current_player.marker} turn, please enter row, column:"
      input = gets.chomp
      row, col = input.split(',').map(&:to_i)
      if valid_move?(row, col)
        @board.update((row - 1), (col - 1), @current_player.marker)
      else
        puts 'Please enter a valid row and col!'
        @board.display
        next
      end
      @board.display

      if winner?
        puts "Player #{@current_player.marker} wins!"
        break
      elsif draw?
        puts 'The game is a draw!'
        break
      end
      @current_player = @current_player == @player1 ? @player2 : @player1
    end
  end

  private

  def valid_move?(row, col)
    if row > 3 || row < 1 || @board.grid[row - 1][col - 1] != '_'
      false
    elsif col > 3 || col < 1 || @board.grid[row - 1][col - 1] != '_'
      false
    else
      true
    end
  end

  def winner?
    (0..2).any? { |i| row_winner?(i) || column_winner?(i) } || diagonal_winner?
  end

  def row_winner?(i)
    @board.grid[i].uniq.size == 1 && @board.grid[i][0] != '_'
  end

  def column_winner?(i)
    @board.grid.map { |row| row[i] }.uniq.size == 1 && @board.grid[0][i] != '_'
  end

  def diagonal_winner?
    [@board.grid[0][0], @board.grid[1][1], @board.grid[2][2]].uniq.size == 1 && @board.grid[0][0] != '_' ||
      [@board.grid[0][2], @board.grid[1][1], @board.grid[2][0]].uniq.size == 1 && @board.grid[0][2] != '_'
  end

  def draw?
    @board.grid.flatten.none?('_')
  end
end
