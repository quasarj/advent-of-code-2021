require '../util'

def center_on_position(crabs, position)
  crabs.map { |crab|
    x = (crab - position).abs
    ((x ** 2) + x) / 2
  }.sum
end

def main
  #input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  input = Util.get_file_input[0].split(',').map { |x| x.to_i }

  result = (input.min..input.max).map { |i|
    center_on_position input, i
  }.min

  p result

end

if __FILE__ == $0
  main
end
