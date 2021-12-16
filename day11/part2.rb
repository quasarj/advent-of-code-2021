# why do we have to require both? part2 requires part1 but doesn't work?
require '../day9/part1'
require '../day9/part2'
require '../util'
require 'set'

class Point
  attr_accessor :x
  attr_accessor :y
  attr_accessor :value

  def initialize(x, y, value, board)
    @x = x
    @y = y
    @value = value
    @board = board
  end

  def coords
    [@x, @y]
  end

  def set(new_value)
    @board.set(@x, @y, new_value)
    @value = new_value
  end

  def inspect
    "<Point: (#{@x},#{@y}) = #{@value}>"
  end

  def adjacents
    @board.adjacents(@x, @y)
  end
end

class Board
  attr_accessor :width
  attr_accessor :height

  def each
    for y in 0..(@height - 1)
      for x in 0..(@width - 1)
        yield self.getyxpoint(y, x)  
      end
    end
  end

  def flash
  end

  def set(x, y, new_value)
    @board[y][x] = new_value
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

    [up_left, up, up_right,
     left, right,
     down_left, down, down_right].map do |x|
       self.getyxpoint(*x)
    end
  end

  def getyxpoint(y, x)
    v = self.getyx(y, x)
    if v == nil
      return nil
    else
      return Point.new(x, y, v, self)
    end
  end
end

def get_test_input
  [
    '5483143223',
    '2745854711',
    '5264556173',
    '6141336146',
    '6357385478',
    '4167524645',
    '2176841721',
    '6882881134',
    '4846848554',
    '5283751526',
  ]
end
def get_simple_input
  [  
    '11111',
    '19991',
    '19191',
    '19991',
    '11111',
  ]
end

def main
  input = get_test_input
  input = Util.get_file_input.map { |x| x.strip }

  b = Board.new input

  step_count = 2000

  (0..(step_count - 1)).each { |x| 
    if do_one_step(b) == -1
        print(x + 1)
        break
    end
  }
end

def do_one_step(b)
  # increase each by one
  b.each do |x|
    x.set x.value + 1
  end

  # build initial list of flashing points
  to_flash = Array.new
  already_flashed = Set.new

  b.each do |x|
    if x.value > 9
      to_flash.append x
    end
  end

  #p to_flash
  #p to_flash.length

  flash_count = 0

  while to_flash.length > 0
    x = to_flash.shift
    if already_flashed.include? x.coords
      next
    end
    flash_count += 1
    already_flashed.add x.coords
    x.set 0

    # increment all adjacents
    # if any of those are now over 9, add to to_flash
    x.adjacents.each do |y|
      if y == nil
        next
      end
      # if it's 0 now, it has already flashed this step and is immune to new energy
      if y.value != 0
        y.set y.value + 1
      end
      if y.value > 9
        to_flash.append y
      end
    end
  end

  #p to_flash
  #p to_flash.length
  #p already_flashed
  #p flash_count
  #p b
  #
  if already_flashed.length >= b.width * b.height
    return -1
  end

  flash_count

end

if __FILE__ == $0
  main
end
