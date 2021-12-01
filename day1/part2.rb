require './part1'

def reduce_to_sliding_window(input)
  window_start = -1
  new = []
  while (window_start + 3) < input.length
    window_start += 1
    slice = input.slice(window_start, 3)
    sum = slice.reduce(:+)
    new.append(sum)
  end

  new
end

def main
  puts calc reduce_to_sliding_window get_file_input
end

if __FILE__ == $0
  main
end
