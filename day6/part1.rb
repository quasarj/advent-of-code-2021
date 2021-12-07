require '../util'

def pass(fish)
  new = []
  for i in 0..(fish.length - 1)
    x = fish[i]
    if x == 0
      x = 6
      new.append(8)
    else
      x -= 1
    end
    fish[i] = x
  end
  fish.concat new
end

def main
  input = Util.get_file_input
  fish = input[0].split(',').map { |x| x.to_i }
  #fish = [3, 4, 3, 1, 2]

  days = 80
  #days = 256
  for d in 0..(days - 1)
    pass fish
  end

  puts fish.length
end

if __FILE__ == $0
  main
end
