class Board
  attr_accessor :grid

  def initialize
    @grid = Array.new(3) { Array.new(3, '_') }
  end

  def display
    @grid.each do |row|
      puts row.join(' | ')
    end
  end

  def update(row, col, marker)
    @grid[row][col] = marker
  end
end
