require 'pp'
require '../util'

class Board
  def initialize(lines = nil)
    if lines != nil
      self.load(lines)
    end
  end

  def load(lines)
    @board = lines.map do |i|
      i.split('').map { |x| x.to_i }
    end
    @width = @board[0].length
    @height = @board.length
  end

  def lows
    output = []
    for y in 0..(@height - 1)
      for x in 0..(@width - 1)
        val = self.getyx(y, x)
        adj = self.adjacents(x, y)
        min = adj.select { |x| x != nil }.min
        if val != nil and val < min
          output.append([val, [x, y]])
          #puts "a low is at: (#{x},#{y})"
        end
      end
    end
    output
  end

  def getyx(y, x)
    if y < 0 or x < 0 or y >= @height or x >= @width
      nil
    else
      @board[y][x]
    end
  end

  def getxy(x, y)
    @board[y][x]
  end

  def adjacents(x, y)
    # return a list of all values adjacent to this one
    # 1 2 3
    # 4 . 5
    # 6 7 8

    up_left = [y - 1, x - 1]
    up = [y - 1, x]
    up_right = [y - 1, x + 1]

    left = [y, x - 1]
    right = [y, x + 1]

    down_left = [y + 1, x - 1]
    down = [y + 1, x]
    down_right = [y + 1, x + 1]

    [
      self.getyx(*up),
      self.getyx(*left),
      self.getyx(*right),
      self.getyx(*down),
    ]
  end
end

def get_test_input
  "2199943210
3987894921
9856789892
8767896789
9899965678".split("\n")
end

def main
  #input = get_test_input
  input = Util.get_file_input.map { |line| line.strip }

  board = Board.new input

  board_lows = board.lows.map do |x|
    val, coords = x
    val + 1
  end
  p board_lows.sum
end

if __FILE__ == $0
  main
end
