def get_file_input
  input = File.readlines("input.txt")
  input.map { |x| x.to_i }
end

def get_test_input
  [
    199,
    200,
    208,
    210,
    200,
    207,
    240,
    269,
    260,
    263
  ]
end

def calc(input)
  inc = 0
  dec = 0
  eq = 0
  last = nil

  for i in input
    if last != nil
      if i > last
        inc += 1
      elsif i < last
        dec += 1
      else
        eq += 1
      end
    end
    last = i
  end

  puts "inc: #{inc}"
  puts "dec: #{dec}"
  puts "eq:  #{eq}"
end

def main
  calc get_file_input
end

if __FILE__ == $0
  main
end
