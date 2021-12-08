require '../util'

def median(array)
  return nil if array.empty?
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

def center_on_position(crabs, position)
  crabs.map { |crab|
    (crab - position).abs
  }.sum
end

def main
  #input = [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  input = Util.get_file_input[0].split(',').map { |x| x.to_i }

  #avg = input.sum / input.length
  med = median(input).to_i

  #p avg
  #p center_on_position input, avg
  p center_on_position input, med


end

if __FILE__ == $0
  main
end
