require '../util'
require './part1'

def reduce_by_bit_pos(match_func, bit_position, input)
  bits = input.map { |f| f[bit_position] }
  match_bit = method(match_func).call(bits)

  new_input = []
  for number in input
    if number[bit_position] == match_bit
      new_input.append(number)
    end
  end
  new_input
end

def calc_oxygen_generator_rating(input)
  bit_position = 0
  while input.length > 1
    input = reduce_by_bit_pos :gamma_of_bits, bit_position, input
    bit_position += 1
  end

  input[0].to_i(2)
end

def calc_co2_scrubber_rating(input)
  bit_position = 0
  while input.length > 1
    input = reduce_by_bit_pos :epsilon_of_bits, bit_position, input
    bit_position += 1
  end

  input[0].to_i(2)
end

def main
  input = Util.get_file_input
  input = input.map { |i| i.strip }
  #input = get_sample_input

  oxy = calc_oxygen_generator_rating input
  co2 =  calc_co2_scrubber_rating input

  puts oxy * co2
end

if __FILE__ == $0
  main
end
