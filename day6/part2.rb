require '../util'

def pass2(fish_counts)
  # shift all values left by one
  # handle v0 last
  current_zero = fish_counts[0]

  for pos in 1..8
    fish_counts[pos - 1] = fish_counts[pos]
  end

  # reset the 8-day fish to 0 before adding new fish
  fish_counts[8] = 0

  if current_zero > 0
    #puts "zero fish today: #{current_zero}"
    fish_counts[6] += current_zero
    fish_counts[8] += current_zero
  end

  fish_counts
end

def main
  input = Util.get_file_input
  fish = input[0].split(',').map { |x| x.to_i }
  #fish = [3, 4, 3, 1, 2]

  # initial state
  fish_counts = [0] * 9
  for f in fish
    fish_counts[f] += 1
  end

  p fish_counts

  days = 256
  for d in 0..(days - 1)
    #puts "Day #{d+1}"
    pass2 fish_counts
    #p fish_counts.reduce(:+)
  end

  puts "final counts:"
  p fish_counts
  p fish_counts.reduce(:+)

end

if __FILE__ == $0
  main
end
