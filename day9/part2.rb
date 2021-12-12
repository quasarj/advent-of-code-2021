require './part1'

class Boarder < Board
  def basins
    low_points = self.lows.map { |low|
      low[1]
    }
    # for each low point, examine all adjacent points, any that are not 9 are 
    # in the basin, and need to be visited themselves

    def find_basin(start_x, start_y)
      #puts "finding basin for #{start_x},#{start_y}"
      @points_to_visit = [[start_x, start_y]]
      @basin_points = [[start_x, start_y]]
      while @points_to_visit.length > 0
        #puts "points_to_visit.length is #{@points_to_visit.length}"
        self.visit(*(@points_to_visit.shift))
        if @points_to_visit.length > 1000
          puts "aborting"
          break
        end
      end
    end

    low_points.map do |point|
      find_basin(*point)
      @basin_points
    end
  end

  def visit(x, y)
    #puts "visiting #{x},#{y}"


    up_left = [y - 1, x - 1]
    up = [y - 1, x]
    up_right = [y - 1, x + 1]

    left = [y, x - 1]
    right = [y, x + 1]

    down_left = [y + 1, x - 1]
    down = [y + 1, x]
    down_right = [y + 1, x + 1]

    for point in [up, left, right, down]
      y, x = *point
      v = getyx(y, x)
      if v != nil and v != 9 
        #puts "#{v} != 9, adding this point!"
        if not @basin_points.include? [x, y]
          @basin_points.push [x, y]
          @points_to_visit.push [x, y]
        end
      end
    end
  end
end

def main
  input = Util.get_file_input.map { |line| line.strip }
  #input = get_test_input

  board = Boarder.new input
  b = board.basins
  bs = b.sort_by { |x| x.length }.reverse

  a =  bs[0].length
  b =  bs[1].length
  c =  bs[2].length

  p a * b * c

end

if __FILE__ == $0
  main
end
