require '../util'

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

#def get_file_input
#  File.readlines("input.txt")
#end

def main
  pos = 0
  depth = 0
  aim = 0

  #for entry in get_test_input
  for entry in Util.get_file_input
    direction, amount = entry.split(" ")
    amount = amount.to_i
    case direction
    when 'forward'
      pos += amount
      depth += (amount * aim)
    when 'up'
      aim -= amount
    when 'down'
      aim += amount
    end
  end

  puts pos * depth
end

if __FILE__ == $0
  main
end
