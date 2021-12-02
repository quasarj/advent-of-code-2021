def get_test_input
  [
    'forward 5',
    'down 5',
    'forward 8',
    'up 3',
    'down 8',
    'forward 2',
  ]
end

def get_file_input
  File.readlines("input.txt")
end

def main
  pos = 0
  depth = 0

  #for entry in get_test_input
  for entry in get_file_input
    direction, amount = entry.split(" ")
    amount = amount.to_i
    case direction
    when 'forward'
      pos += amount
    when 'up'
      depth -= amount
    when 'down'
      depth += amount
    end
  end

  puts pos * depth
end

if __FILE__ == $0
  main
end
