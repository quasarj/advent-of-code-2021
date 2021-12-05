require '../util'

class Line
  def initialize(x1, y1, x2, y2)
    @x1 = x1
    @y1 = y1
    @x2 = x2
    @y2 = y2
  end

  def straight?
    @x1 == @x2 or @y1 == @y2
  end

  def slope
    (@y1 - @y2) / (@x1 - @x2)
  end

  def test
    def distance(x1, y1, x2, y2)
      Math.sqrt((x2 - x1) ** 2 + (y2 - y1) ** 2)
    end
    intercept = ((1 - slope) * @x1) + @y1
    
    x = @x1 - 5
    y = slope * (x - @x1) + @y1

    p distance(@x1, @y1, x, y)
  end

  def points
    # output all points this line covers
    points = []
    if @x1 == @x2
      bigger = if @y1 > @y2 then @y1 else @y2 end
      smaller = if @y1 < @y2 then @y1 else @y2 end
      for i in smaller..bigger
        points.append([@x1, i])
      end
    elsif @y1 == @y2
      bigger = if @x1 > @x2 then @x1 else @x2 end
      smaller = if @x1 < @x2 then @x1 else @x2 end
      for i in smaller..bigger
        points.append([i, @y1])
      end
    else
      if @x1 < @x2
        x = @x1
        y = @y1

        x_end = @x2
        y_end = @y2
      else
        x = @x2
        y = @y2

        x_end = @x1
        y_end = @y1
      end

      points.append([x, y])
      while not (x == x_end and y == y_end)
        x += 1
        y += slope
        points.append([x, y])
      end
    end
    points
  end

  def inspect; self.to_s; end
  def to_s
    "<Line: #{@x1},#{@y1} -> #{@x2},#{@y2}>"
  end
end

def get_test_input
  [
    '0,9 -> 5,9',
    '8,0 -> 0,8',
    '9,4 -> 3,4',
    '2,2 -> 2,1',
    '7,0 -> 7,4',
    '6,4 -> 2,0',
    '0,9 -> 2,9',
    '3,4 -> 1,4',
    '0,0 -> 8,8',
    '5,5 -> 8,2',
  ]
end

def parse_input(input)
  # parse into line coordinates
  input.map do |line|
    a, b = line.split('->').map { |x| x.strip }
    x1, y1 = a.split(',').map { |x| x.to_i }
    x2, y2 = b.split(',').map { |x| x.to_i }

    Line.new(x1, y1, x2, y2)
  end
end

def main
  #input = parse_input get_test_input
  input = parse_input Util.get_file_input

  # keep only horizontal or vertical lines (omit all diagnals)
  #input = input.select do |l|
  #  not l.straight?
  #end

  # for l in input
  #   p l
  #   puts l.slope
  #   p l.points
  # end

  points = {}
  points.default = 0

  for l in input
    #p l
    for p in l.points
      points[p] += 1
    end
  end

  overlap = 0
  points.each do |key, value|
    if value > 1
      overlap += 1
    end
  end

  puts overlap

  
end

if __FILE__ == $0
  main
end
